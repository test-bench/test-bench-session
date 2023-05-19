require_relative '../../automated_init'

context "Output" do
  context "Comment" do
    context "Optional Heading" do
      text = "Some text"
      heading = "Some Heading:"

      context "Quoted" do
        quote = true
        commented = Controls::Events::Commented.example(heading:, quote:, text:)

        output = Controls::Output::Styling.example

        context "Handle Commented Event" do
          output.handle(commented)

          context "Written Text" do
            writer = output.writer
            written_text = writer.written_text

            control_text = <<~TEXT
            \e[1;4m#{heading}\e[0m
            \e[2m> \e[22m#{text}\e[0m
            TEXT

            comment written_text
            detail "Control Text:", control_text

            test do
              assert(writer.written?(control_text))
            end
          end
        end
      end

      context "Not Quoted" do
        quote = false
        commented = Controls::Events::Commented.example(heading:, quote:, text:)

        output = Controls::Output::Styling.example

        context "Handle Commented Event" do
          output.handle(commented)

          context "Written Text" do
            writer = output.writer
            written_text = writer.written_text

            control_text = <<~TEXT
            \e[1;4m#{heading}\e[0m
            #{text}\e[0m
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
