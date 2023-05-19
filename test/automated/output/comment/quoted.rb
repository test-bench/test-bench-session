require_relative '../../automated_init'

context "Output" do
  context "Comment" do
    context "Quoted" do
      quote = true

      context "No Heading" do
        omit_heading = true
        commented = Controls::Events::Commented::MultipleLines.example(omit_heading:, quote:)

        output = Controls::Output::Styling.example

        context "Handle Commented Event" do
          output.handle(commented)

          context "Written Text" do
            writer = output.writer
            written_text = writer.written_text

            control_text = <<~TEXT
            \e[2m> \e[22mSome comment\e[0m
            \e[2m> \e[22mSome other comment\e[0m
            \e[2m> \e[22mYet another comment\e[0m
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
        commented = Controls::Events::Commented::MultipleLines.example(quote:)
        heading = commented.heading

        output = Controls::Output::Styling.example

        context "Handle Commented Event" do
          output.handle(commented)

          context "Written Text" do
            writer = output.writer
            written_text = writer.written_text

            control_text = <<~TEXT
            \e[1;4m#{heading}\e[0m
            \e[2m> \e[22mSome comment\e[0m
            \e[2m> \e[22mSome other comment\e[0m
            \e[2m> \e[22mYet another comment\e[0m
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
