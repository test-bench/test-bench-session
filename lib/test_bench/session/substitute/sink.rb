module TestBench
  class Session
    module Substitute
      class Sink
        include Telemetry::Sink
        include Events

        def records
          @records ||= []
        end
        attr_writer :records

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

        Record = Struct.new(:event_data, :path)
      end
    end
  end
end
