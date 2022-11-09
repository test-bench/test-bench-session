module TestBench
  class Session
    module Controls
      module Events
        module Detailed
          def self.example(text: nil, quote: nil, heading: nil, process_id: nil, time: nil)
            quote = self.quote if quote.nil?
            process_id ||= self.process_id
            time ||= self.time

            if text == :none
              text = nil
            else
              text ||= self.text
            end

            Session::Events::Detailed.build(text, quote, heading, process_id:, time:)
          end

          def self.random(text: nil, heading: nil)
            text ||= Detail::Text.random

            quote = Detail::Quote.random
            process_id = ProcessID.random
            time = Time.random

            example(text:, quote:, heading:, process_id:, time:)
          end

          def self.text = Detail::Text.example
          def self.quote = false
          def self.process_id = ProcessID.example
          def self.time = Time.example

          module MultipleLines
            def self.example(omit_heading: nil, heading: nil, **attributes)
              omit_heading ||= !heading.nil?

              if not omit_heading
                heading ||= self.heading
              end

              Detailed.example(text:, heading:, **attributes)
            end

            def self.random(omit_heading: nil)
              omit_heading ||= false

              suffix = Controls::Random.string

              if not omit_heading
                heading = Detail::Heading.random(suffix)
              end

              text = Detail::Text::MultipleLines.random(suffix)

              Detailed.random(text:, heading:)
            end

            def self.text = Detail::Text::MultipleLines.example
            def self.quote = true
            def self.heading = Detail::Heading.example
          end
        end
      end
    end
  end
end
