module TestBench
  class Session
    module Substitute
      def self.build
        Session.build
      end

      class Session < Session
        attr_accessor :result

        def self.build
          instance = new

          telemetry = instance.telemetry
          Telemetry::CaptureSink.configure(telemetry, attr_name: :sink)

          telemetry.register(telemetry.sink)

          instance
        end

        def file(path)
          telemetry.record(Events::FileStarted.new(path))

          telemetry.record(Events::FileFinished.new(path, result))

          result
        end

        Events.each_type do |event_type|
          event_type_method_cased = TestBench::Telemetry::Event::Type.method_cased(event_type)

          event_class = Events.const_get(event_type, false)

          module_eval(<<~RUBY, __FILE__, __LINE__)
          def one_#{event_type_method_cased}_event?(...)
            one_event?(#{event_class}, ...)
          end

          def one_#{event_type_method_cased}_event(...)
            one_event(#{event_class}, ...)
          end

          def any_#{event_type_method_cased}_event?(...)
            any_event?(#{event_class}, ...)
          end
          alias :#{event_type_method_cased}_event? :any_#{event_type_method_cased}_event?

          def #{event_type_method_cased}_events(...)
            events(#{event_class}, ...)
          end
          RUBY
        end

        def one_event?(...) = telemetry.one_event?(...)
        def one_event(...) = telemetry.one_event(...)
        def any_event?(...) = telemetry.any_event?(...)
        alias :event? :any_event?
        def events(...) = telemetry.events(...)

        alias :failure? :failed_event?
        alias :one_failure? :one_failed_event?

        alias :test? :test_finished_event?
        alias :one_test? :one_test_finished_event?

        alias :context? :context_finished_event?
        alias :one_context? :one_context_finished_event?

        alias :comment? :commented_event?
        alias :one_comment? :one_commented_event?

        alias :detail? :detailed_event?
        alias :one_detail? :one_detailed_event?

        alias :fixture? :fixture_finished_event?
        alias :one_fixture? :one_fixture_finished_event?

        alias :file? :file_finished_event?
        alias :one_file? :one_file_finished_event?

        alias :started? :started_event?
        alias :one_started? :one_started_event?

        alias :finished? :finished_event?
        alias :one_finished? :one_finished_event?

        alias :aborted? :aborted_event?
        alias :one_aborted? :one_aborted_event?
      end
    end
  end
end
