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
      end
    end
  end
end
