module TestBench
  class Session
    module Controls
      module Events
        module ContextStarted
          def self.example(title: nil, process_id: nil, time: nil)
            process_id ||= self.process_id
            time ||= self.time

            if title == :none
              title = nil
            else
              title ||= self.title
            end

            Session::Events::ContextStarted.build(title, process_id:, time:)
          end

          def self.random(include_title: nil)
            include_title = true if include_title.nil?

            process_id = ProcessID.random
            time = Time.random

            if include_title
              title = Title::Test.random
            else
              title = :none
            end

            example(title:, process_id:, time:)
          end

          def self.title = Title::Context.example
          def self.process_id = ProcessID.example
          def self.time = Time.example

          module NoTitle
            def self.example(**arguments)
              ContextStarted.example(title: :none, **arguments)
            end
            def self.random = ContextStarted.random(include_title: false)
          end
        end
      end
    end
  end
end
