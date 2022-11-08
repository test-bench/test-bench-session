module TestBench
  class Session
    module Controls
      module Events
        module ContextSkipped
          def self.example(title: nil, process_id: nil, time: nil)
            title ||= self.title
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::ContextSkipped.new(title, process_id, time)
          end

          def self.random
            title = Title::Context.random
            process_id = ProcessID.random
            time = Time.random

            example(title:, process_id:, time:)
          end

          def self.title = Title::Context.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
