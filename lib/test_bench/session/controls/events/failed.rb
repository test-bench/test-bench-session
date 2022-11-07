module TestBench
  class Session
    module Controls
      module Events
        module Failed
          def self.example(message: nil, process_id: nil, time: nil)
            message ||= self.message
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::Failed.build(message, process_id:, time:)
          end

          def self.random
            message = Failure::Message.random
            process_id = ProcessID.random
            time = Time.random

            example(message:, process_id:, time:)
          end

          def self.message = Failure::Message.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
