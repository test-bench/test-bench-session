module TestBench
  class Session
    module Controls
      module Events
        module Started
          def self.example(process_count: nil, process_id: nil, time: nil)
            process_count ||= self.process_count
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::Started.new(process_count, process_id, time)
          end

          def self.random
            process_count = Random.integer
            process_id = ProcessID.random
            time = Time.random

            example(process_count:, process_id:, time:)
          end

          def self.process_count = 11
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
