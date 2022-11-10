module TestBench
  class Session
    module Telemetry
      class CaptureSink
        include TestBench::Telemetry::Sink
        include Events

        def records
          @records ||= []
        end

        def path
          @path ||= Path.new
        end
        attr_writer :path

        def call(event)
          case event
          when TestStarted, ContextStarted
            path.push(event.title)
          when TestFinished, ContextFinished
            path.pop(event.title)
          end

          record = Record.new(event)
          path.copy(record)

          case event
          when TestFinished, ContextFinished
            title = event.title
            record.path.push(title)
          when Commented, Detailed
            comment_text = event.text
            record.path.push(comment_text)
          end

          records.push(record)

          record
        end
      end
    end
  end
end
