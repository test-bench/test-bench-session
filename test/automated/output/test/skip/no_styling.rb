require_relative '../../../automated_init'

context "Output" do
  context "Test" do
    context "Skip" do
      context "No Styling" do
        output = Controls::Output.example

        output.handle(Controls::Events::TestSkipped.example(title: "Some Skipped Test"))

        context "Written Text" do
          writer = output.writer
          written_text = writer.written_text

          control_text = <<~TEXT
          Some Skipped Test (skipped)
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
