require_relative '../../automated_init'

context "Output" do
  context "Comment" do
    context "No Styling" do
      text = Controls::Events::Commented.text

      context "Heading" do
        heading = "Some Heading:"

        context "Quoted" do
          quote = true

          commented = Controls::Events::Commented.example(quote:, heading:, text:)

          output = Controls::Output.example

          context "Handle Commented Event" do
            output.handle(commented)

            context "Written Text" do
              writer = output.writer
              written_text = writer.written_text

              control_text = <<~TEXT
              #{heading}
              - - -
              > #{text}
              TEXT

              comment written_text
              detail "Control:", control_text

              test do
                assert(writer.written?(control_text))
              end
            end
          end
        end

        context "Not Quoted" do
          quote = false

          commented = Controls::Events::Commented.example(quote:, heading:, text:)

          output = Controls::Output.example

          context "Handle Commented Event" do
            output.handle(commented)

            context "Written Text" do
              writer = output.writer
              written_text = writer.written_text

              control_text = <<~TEXT
              #{heading}
              - - -
              #{text}
              TEXT

              comment written_text
              detail "Control:", control_text

              test do
                assert(writer.written?(control_text))
              end
            end
          end
        end
      end

      context "No Heading" do
        context "Quoted" do
          quote = true

          commented = Controls::Events::Commented.example(quote:, text:)

          output = Controls::Output.example

          context "Handle Commented Event" do
            output.handle(commented)

            context "Written Text" do
              writer = output.writer
              written_text = writer.written_text

              control_text = <<~TEXT
              > #{text}
              TEXT

              comment written_text
              detail "Control:", control_text

              test do
                assert(writer.written?(control_text))
              end
            end
          end
        end

        context "Not Quoted" do
          quote = false

          commented = Controls::Events::Commented.example(quote:, text:)

          output = Controls::Output.example

          context "Handle Commented Event" do
            output.handle(commented)

            context "Written Text" do
              writer = output.writer
              written_text = writer.written_text

              control_text = <<~TEXT
              #{text}
              TEXT

              comment written_text
              detail "Control:", control_text

              test do
                assert(writer.written?(control_text))
              end
            end
          end
        end
      end
    end
  end
end
