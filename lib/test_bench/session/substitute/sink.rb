module TestBench
  class Session
    module Substitute
      class Sink
        include Telemetry::Sink
        include Events

        def records
          @records ||= []
        end

        def path
          @path ||= Path.new
        end
        attr_writer :path

        def receive(event_data)
          event_type = event_data.type

          case event_data.type
          when :TestStarted, :ContextStarted
            title, * = event_data.data
            path.push(title)
          when :TestFinished, :ContextFinished
            title, * = event_data.data
            path.pop(title)
          end

          record = Record.new(event_data)
          path.copy(record)

          case event_data.type
          when :TestFinished, :ContextFinished
            title, * = event_data.data
            record.path.push(title)
          when :Commented, :Detailed
            comment_text, * = event_data.data
            record.path.push(comment_text)
          end

          records.push(record)

          record
        end

        def any_event?(event_class, *path_segments, **attributes)
          event_sink = event_sink(*path_segments)
          event_sink.any_event?(event_class, **attributes)
        end
        alias :event? :any_event?

        def events(event_class, *path_segments, **attributes)
          event_sink = event_sink(*path_segments)
          event_sink.events(event_class, **attributes)
        end

        def event_sink(*path_segments)
          event_sink = Telemetry::Substitute::Sink.new

          records.each do |record|
            if record.match?(path_segments)
              event_data = record.event_data

              event_sink.receive(event_data)
            end
          end

          event_sink
        end

        Record = Struct.new(:event_data, :path) do
          def match?(path_segments)
            if path_segments.any?
              path.match?(*path_segments)
            else
              true
            end
          end
        end
      end
    end
  end
end
