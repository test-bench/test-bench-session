module TestBench
  class Session
    module Controls
      module CaptureSink
        module Path
          module Segment
            def self.examples
              [example, Context.other_example, Test.example]
            end

            def self.example = Context.example

            Test = Title::Test
            Context = Title::Context
          end
        end
      end
    end
  end
end
