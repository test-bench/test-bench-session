module TestBench
  class Session
    module Controls
      module Events
        module ContextFinished
          def self.example(title: nil, result: nil, process_id: nil, time: nil)
            title ||= self.title
            result = self.result if result.nil?
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::ContextFinished.new(title, result, process_id, time)
          end

          def self.random
            title = Title::Context.random
            result = Result.random
            process_id = ProcessID.random
            time = Time.random

            example(title:, result:, process_id:, time:)
          end

          def self.title = Title::Context.example
          def self.result = Result.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
