module TestBench
  class Session
    module Controls
      module Comment
        module Text
          def self.example(suffix=nil, text: nil)
            text ||= self.text
            suffix = " #{suffix}" if not suffix.nil?

            "#{text}#{suffix}"
          end
          def self.random = example(Random.string)

          def self.text = "Some comment"

          module MultipleLines
            def self.example(suffix=nil, lines: nil)
              lines ||= self.lines

              text = String.new

              lines.map do |line|
                text << Text.example(suffix, text: line)
                text << "\n"
              end

              text
            end

            def self.random(suffix=nil)
              suffix ||= Random.string

              example(suffix)
            end

            def self.lines
              [
                "Some comment",
                "Some other comment",
                "Yet another comment"
              ]
            end
          end
        end

        module Heading
          def self.example(suffix=nil, text: nil)
            text ||= self.text

            heading = Text.example(suffix, text:)
            heading << ":"
            heading
          end

          def self.random(suffix=nil)
            suffix ||= Random.string

            example(suffix)
          end

          def self.text = "Some Comment Heading"
        end

        module Quote
          def self.example = true
          def self.random = Random.boolean
        end
      end
    end
  end
end
