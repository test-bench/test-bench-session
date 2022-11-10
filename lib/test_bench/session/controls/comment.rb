module TestBench
  class Session
    module Controls
      module Comment
        module Text
          def self.example(suffix=nil)
            suffix = " #{suffix}" if not suffix.nil?

            "Some comment#{suffix}"
          end
          def self.random = example(Random.string)
        end
      end
    end
  end
end
