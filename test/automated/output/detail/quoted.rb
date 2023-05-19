require_relative '../../automated_init'

context "Output" do
  context "Detail" do
    context "Quoted" do
      quote = true

      context "No Heading" do
        omit_heading = true
        detailed = Controls::Events::Detailed::MultipleLines.example(omit_heading:, quote:)

        output = Controls::Output::Styling.example

        output.writer.increase_indentation

        context "Handle Detailed Event" do
          output.handle(detailed)

          context "Written Text" do
            writer = output.writer
            written_text = writer.written_text

            control_text = <<-TEXT
  \e[2m> \e[22mSome detail\e[0m
  \e[2m> \e[22mSome other detail\e[0m
  \e[2m> \e[22mYet another detail\e[0m
            TEXT

            comment written_text
            detail "Control Text:", control_text

            test do
              assert(writer.written?(control_text))
            end
          end
        end
      end

      context "Heading" do
        detailed = Controls::Events::Detailed::MultipleLines.example(quote:)
        heading = detailed.heading

        context "Styling" do
          output = Controls::Output::Styling.example

          output.writer.increase_indentation

          context "Handle Detailed Event" do
            output.handle(detailed)

            context "Written Text" do
              writer = output.writer
              written_text = writer.written_text

              control_text = <<-TEXT
  \e[1;4m#{heading}\e[0m
  \e[2m> \e[22mSome detail\e[0m
  \e[2m> \e[22mSome other detail\e[0m
  \e[2m> \e[22mYet another detail\e[0m
            TEXT

              comment written_text
              detail "Control Text:", control_text

              test do
                assert(writer.written?(control_text))
              end
            end
          end
        end

        context "No Styling" do
          output = Controls::Output.example

          output.writer.increase_indentation

          context "Handle Detailed Event" do
            output.handle(detailed)

            context "Written Text" do
              writer = output.writer
              written_text = writer.written_text

              control_text = <<-TEXT
  #{heading}
  - - -
  > Some detail
  > Some other detail
  > Yet another detail
            TEXT

              comment written_text
              detail "Control Text:", control_text

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
