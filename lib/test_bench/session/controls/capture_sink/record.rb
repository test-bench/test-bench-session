module TestBench
  class Session
    module Controls
      module CaptureSink
        module Record
          def self.example(event: nil, path: nil)
            event ||= self.event
            path ||= self.path

            TestBench::Session::Telemetry::CaptureSink::Record.new(event, path)
          end

          def self.event = Event.example
          def self.path = Path.example
        end
      end
    end
  end
end
