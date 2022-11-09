module TestBench
  class Session
    module Controls
      module Detail
        module Text
          def self.example(suffix=nil)
            Comment::Text.example(suffix, text:)
          end
          def self.random = example(Random.string)

          def self.text = "Some detail"

          module MultipleLines
            def self.example(suffix=nil)
              Comment::Text::MultipleLines.example(suffix, lines:)
            end

            def self.random(suffix=nil)
              suffix ||= Random.string

              example(suffix)
            end

            def self.lines
              [
                "Some detail",
                "Some other detail",
                "Yet another detail"
              ]
            end
          end
        end

        module Heading
          def self.example(suffix=nil)
            Comment::Heading.example(suffix, text:)
          end

          def self.random(suffix=nil)
            suffix ||= Random.string

            example(suffix)
          end

          def self.text = "Some Detail Heading"
        end

        module Quote
          def self.example = true
          def self.random = Random.boolean
        end
      end
    end
  end
end
