module TestBench
  class Session
    module Controls
      module Title
        module Test
          def self.example(suffix=nil)
            suffix = " #{suffix}" if not suffix.nil?

            "Some test#{suffix}"
          end
          def self.other_example = "Some other test"
          def self.random = example(Random.string)
        end

        module Context
          def self.example(suffix=nil)
            suffix = " #{suffix}" if not suffix.nil?

            "Some Context#{suffix}"
          end
          def self.other_example = "Some Other Context"
          def self.random = example(Random.string)
        end
      end
    end
  end
end
