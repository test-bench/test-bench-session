module TestBench
  class Session
    module Controls
      module Failure
        module Message
          def self.example(suffix=nil)
            suffix = " #{suffix}" if not suffix.nil?

            "Some failure message#{suffix}"
          end
          def self.random = example(Controls::Random.string)
        end

        module Path
          def self.example(suffix=nil)
            suffix = "_#{suffix}" if not suffix.nil?

            "path/to/some_file#{suffix}.rb"
          end
          def self.random = example(Controls::Random.string)
        end

        module LineNumber
          def self.example = 11
          def self.random = Controls::Random.integer % 1111
        end
      end
    end
  end
end
