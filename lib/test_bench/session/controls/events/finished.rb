module TestBench
  class Session
    module Controls
      module Events
        module Finished
          def self.example(result: nil, process_count: nil, process_id: nil, time: nil)
            result ||= self.result
            process_count ||= self.process_count
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::Finished.new(result, process_count, process_id, time)
          end

          def self.random
            result = Result.random
            process_count = Random.integer
            process_id = ProcessID.random
            time = Time.random

            example(result:, process_count:, process_id:, time:)
          end

          def self.result = Result.example
          def self.process_count = Started.process_count
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
