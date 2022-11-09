module TestBench
  class Session
    module Controls
      module Fixture
        module Name
          def self.example(suffix=nil)
            suffix = "_#{suffix}" if not suffix.nil?

            "SomeNamespace::SomeFixture#{suffix}"
          end
          def self.random = example(Random.string)
        end
      end
    end
  end
end
