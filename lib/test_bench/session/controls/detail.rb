module TestBench
  class Session
    module Controls
      module Detail
        module Text
          def self.example(suffix=nil)
            suffix = " #{suffix}" if not suffix.nil?

            "Some detail#{suffix}"
          end
          def self.random = example(Random.string)
        end
      end
    end
  end
end
