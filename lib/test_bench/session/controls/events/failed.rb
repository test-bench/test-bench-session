module TestBench
  class Session
    module Controls
      module Events
        module Failed
          def self.example(message: nil, path: nil, line_number: nil, process_id: nil, time: nil)
            message ||= self.message
            path ||= self.path
            line_number ||= self.line_number
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::Failed.new(message, path, line_number, process_id, time)
          end

          def self.random
            message = Failure::Message.random
            path = Failure::Path.random
            line_number = Failure::LineNumber.random
            process_id = ProcessID.random
            time = Time.random

            example(message:, path:, line_number:, process_id:, time:)
          end

          def self.message = Failure::Message.example
          def self.path = Failure::Path.example
          def self.line_number = Failure::LineNumber.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
