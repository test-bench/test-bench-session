module TestBench
  class Session
    module Controls
      module Events
        module Aborted
          def self.example(abort_process_id: nil, process_id: nil, time: nil)
            abort_process_id ||= self.abort_process_id
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::Aborted.new(abort_process_id, process_id, time)
          end

          def self.random
            abort_process_id = Random.integer
            process_id = ProcessID.random
            time = Time.random

            example(abort_process_id:, process_id:, time:)
          end

          def self.abort_process_id = ProcessID.other
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
