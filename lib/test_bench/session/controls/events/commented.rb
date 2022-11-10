module TestBench
  class Session
    module Controls
      module Events
        module Commented
          def self.example(text: nil, quote: nil, heading: nil, process_id: nil, time: nil)
            quote = self.quote if quote.nil?
            process_id ||= self.process_id
            time ||= self.time

            if text == :none
              text = nil
            else
              text ||= self.text
            end

            Session::Events::Commented.build(text, quote, heading, process_id:, time:)
          end

          def self.random(text: nil, heading: nil)
            text ||= Comment::Text.random

            quote = Comment::Quote.random
            process_id = ProcessID.random
            time = Time.random

            example(text:, quote:, heading:, process_id:, time:)
          end

          def self.text = Comment::Text.example
          def self.quote = false
          def self.process_id = ProcessID.example
          def self.time = Time.example

          module MultipleLines
            def self.example(omit_heading: nil, heading: nil, **attributes)
              omit_heading ||= !heading.nil?

              if not omit_heading
                heading ||= self.heading
              end

              Commented.example(text:, quote:, heading:, **attributes)
            end

            def self.random(omit_heading: nil)
              omit_heading ||= false

              suffix = Controls::Random.string

              if not omit_heading
                heading = Comment::Heading.random(suffix)
              end

              text = Comment::Text::MultipleLines.random(suffix)

              Commented.random(text:, heading:)
            end

            def self.text = Comment::Text::MultipleLines.example
            def self.quote = true
            def self.heading = Comment::Heading.example
          end
        end
      end
    end
  end
end
