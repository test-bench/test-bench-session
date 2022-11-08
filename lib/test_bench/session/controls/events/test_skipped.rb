module TestBench
  class Session
    module Controls
      module Events
        module TestSkipped
          def self.example(title: nil, process_id: nil, time: nil)
            title ||= self.title
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::TestSkipped.new(title, process_id, time)
          end

          def self.random
            title = Title::Test.random
            process_id = ProcessID.random
            time = Time.random

            example(title:, process_id:, time:)
          end

          def self.title = Title::Test.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
