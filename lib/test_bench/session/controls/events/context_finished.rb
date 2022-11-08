module TestBench
  class Session
    module Controls
      module Events
        module ContextFinished
          def self.example(title: nil, result: nil, process_id: nil, time: nil)
            result = self.result if result.nil?
            process_id ||= self.process_id
            time ||= self.time

            if title == :none
              title = nil
            else
              title ||= self.title
            end

            Session::Events::ContextFinished.build(title, result, process_id:, time:)
          end

          def self.random(include_title: nil)
            include_title = true if include_title.nil?

            result = Result.random
            process_id = ProcessID.random
            time = Time.random

            if include_title
              title = Title::Context.random
            else
              title = :none
            end

            example(title:, result:, process_id:, time:)
          end

          def self.title = Title::Context.example
          def self.result = Result.example
          def self.process_id = ProcessID.example
          def self.time = Time.example

          module NoTitle
            def self.example(**arguments)
              ContextFinished.example(title: :none, **arguments)
            end
            def self.random = ContextFinished.random(include_title: false)
          end
        end
      end
    end
  end
end
