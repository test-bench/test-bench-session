module TestBench
  class Session
    module Controls
      module Events
        module Commented
          def self.example(text: nil, process_id: nil, time: nil)
            text ||= self.text
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::Commented.new(text, process_id, time)
          end

          def self.random
            text = Comment::Text.random
            process_id = ProcessID.random
            time = Time.random

            example(text:, process_id:, time:)
          end

          def self.text = Comment::Text.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
