module TestBench
  class Session
    module Controls
      module Events
        module TestFinished
          extend EventData

          def self.example(title: nil, result: nil, process_id: nil, time: nil)
            result = self.result if result.nil?
            process_id ||= self.process_id
            time ||= self.time

            if title == :none
              title = nil
            else
              title ||= self.title
            end

            Session::Events::TestFinished.build(title, result, process_id:, time:)
          end

          def self.random
            Random.example
          end

          def self.title
            Title::Test.example
          end

          def self.result
            Result.example
          end

          def self.process_id
            ProcessID.example
          end

          def self.time
            Time.example
          end

          module Random
            extend EventData

            def self.example(title: nil, result: nil, process_id: nil, time: nil)
              result = Result.random if result.nil?
              process_id ||= ProcessID.random
              time ||= Time.random
              title ||= Title::Test.random

              TestFinished.example(title:, result:, process_id:, time:)
            end
          end

          module NoTitle
            extend EventData

            def self.example(**arguments)
              TestFinished.example(title: :none, **arguments)
            end

            def self.random
              Random.example(title: :none)
            end
          end
        end
      end
    end
  end
end
