module TestBench
  class Session
    module Controls
      module Substitute
        module Path
          module Segment
            def self.examples
              [example, Context.other_example, Test.example]
            end

            def self.example
              Context.example
            end

            Test = Title::Test

            Context = Title::Context
          end
        end
      end
    end
  end
end
