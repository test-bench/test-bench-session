module TestBench
  class Session
    module Controls
      module Events
        module FileFinished
          def self.example(path: nil, result: nil, process_id: nil, time: nil)
            path ||= self.path
            result ||= self.result
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::FileFinished.new(path, result, process_id, time)
          end

          def self.random
            path = File::Path.random
            result = Result.random
            process_id = ProcessID.random
            time = Time.random

            example(path:, result:, process_id:, time:)
          end

          def self.path = File::Path.example
          def self.result = Result.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
