module TestBench
  class Session
    module Controls
      module Events
        module Detailed
          def self.example(text: nil, process_id: nil, time: nil)
            text ||= self.text
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::Detailed.new(text, process_id, time)
          end

          def self.random
            text = Detail::Text.random
            process_id = ProcessID.random
            time = Time.random

            example(text:, process_id:, time:)
          end

          def self.text = Detail::Text.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
