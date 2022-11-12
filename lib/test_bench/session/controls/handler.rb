module TestBench
  class Session
    module Controls
      module Handler
        def self.example
          Example.new
        end

        module Event
          def self.example(text=nil)
            Events::Commented.example(text:)
          end

          def self.other_example
            Events::Detailed.example
          end
        end

        class Example
          include TestBench::Session::Handler

          attr_accessor :text

          handle Commented do |text|
            self.text = text
          end

          def handled?(text=nil)
            if text.nil?
              !self.text.nil?
            else
              text == self.text
            end
          end
        end
      end
    end
  end
end
