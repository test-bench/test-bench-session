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

        Events.each_type do |event_type|
          event_name = TestBench::Telemetry::Event::EventName.get(event_type)

          event_class = Events.const_get(event_type, false)

          module_eval(<<~RUBY, __FILE__, __LINE__)
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

        def one_event(...) = sink.one_event(...)
        def any_event?(...) = sink.any_event?(...)
        alias :event? :any_event?
        def events(...) = sink.events(...)
      end
    end
  end
end
