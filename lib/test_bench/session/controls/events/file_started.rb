module TestBench
  class Session
    module Controls
      module Events
        module FileStarted
          def self.example(path: nil, process_id: nil, time: nil)
            path ||= self.path
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::FileStarted.new(path, process_id, time)
          end

          def self.random
            path = File::Path.random
            process_id = ProcessID.random
            time = Time.random

            example(path:, process_id:, time:)
          end

          def self.path = File::Path.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
