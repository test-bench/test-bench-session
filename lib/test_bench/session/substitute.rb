module TestBench
  class Session
    module Substitute
      def self.build
        Session.build
      end

      class Session < Session
        attr_accessor :result

        def sink
          @sink ||= Sink.new
        end
        attr_writer :sink

        def self.build
          instance = new

          telemetry = instance.telemetry
          telemetry.register(instance.sink)

          instance
        end

        def file(path)
          record_event(Events::FileStarted.new(path))

          record_event(Events::FileFinished.new(path, result))

          result
        end

        Events.each_type do |event_type|
          event_name = TestBench::Telemetry::Event::EventName.get(event_type)

          event_class = Events.const_get(event_type, false)

          module_eval(<<~RUBY, __FILE__, __LINE__)
          def one_#{event_name}_event?(...)
            one_event?(#{event_class}, ...)
          end

          def one_#{event_name}_event(...)
            one_event(#{event_class}, ...)
          end

          def any_#{event_name}_event?(...)
            any_event?(#{event_class}, ...)
          end
          alias :#{event_name}_event? :any_#{event_name}_event?

          def #{event_name}_events(...)
            events(#{event_class}, ...)
          end
          RUBY
        end

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

        def one_event?(...) = sink.one_event?(...)
        def one_event(...) = sink.one_event(...)
        def any_event?(...) = sink.any_event?(...)
        alias :event? :any_event?
        def events(...) = sink.events(...)
      end
    end
  end
end
