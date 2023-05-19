require_relative '../../../automated_init'

context "Output" do
  context "Test" do
    context "Skip" do
      output = Controls::Output::Styling.example

      output.handle(Controls::Events::TestSkipped.example(title: "Some Skipped Test"))
      output.handle(Controls::Events::TestSkipped.example(title: "Some Other Skipped Test"))

      context "Written Text" do
        writer = output.writer
        written_text = writer.written_text

        control_text = <<~TEXT
        \e[33mSome Skipped Test\e[0m
        \e[33mSome Other Skipped Test\e[0m
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
