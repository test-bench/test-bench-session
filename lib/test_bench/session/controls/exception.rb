module TestBench
  class Session
    module Controls
      module Exception
        def self.example(message=nil)
          message ||= self.message

          Example.new(message)
        end
        def self.random = example(Message.random)

        def self.message = "Some message"

        module Message
          def self.example(suffix=nil)
            suffix = " #{suffix}" if not suffix.nil?

            "Some exception message#{suffix}"
          end
          def self.random = example(Controls::Random.string)
        end

        Example = Class.new(RuntimeError)
      end
    end
  end
end
