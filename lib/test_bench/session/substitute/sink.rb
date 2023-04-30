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
            if not title.nil?
              path.push(title)
            end

          when :TestFinished, :ContextFinished
            title, * = event_data.data
            if not title.nil?
              path.pop(title)
            end
          end

          record = Record.new(event_data)
          path.copy(record)

          case event_data.type
          when :TestFinished, :ContextFinished
            title, * = event_data.data
            if not title.nil?
              record.path.push(title)
            end

          when :Commented, :Detailed
            comment_text, * = event_data.data
            record.path.push(comment_text)
          end

          records.push(record)

          record
        end

        def received?(event_data=nil)
          if not event_data.nil?
            records.any? do |record|
              record.event_data == event_data
            end
          else
            records.any?
          end
        end

        Record = Struct.new(:event_data, :path)
      end
    end
  end
end
