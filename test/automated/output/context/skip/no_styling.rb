require_relative '../../../automated_init'

context "Output" do
  context "Context" do
    context "Skip" do
      context "No Styling" do
        output = Controls::Output.example

        output.handle(Controls::Events::ContextSkipped.example(title: "Some Skipped Context"))

        context "Written Text" do
          writer = output.writer
          written_text = writer.written_text

          control_text = <<~TEXT
          Some Skipped Context (skipped)
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
