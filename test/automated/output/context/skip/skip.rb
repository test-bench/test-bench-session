require_relative '../../../automated_init'

context "Output" do
  context "Context" do
    context "Skip" do
      output = Controls::Output::Styling.example

      telemetry = Telemetry.new
      telemetry.register(output)

      telemetry.record(Controls::Events::ContextStarted.example)
      telemetry.record(Controls::Events::ContextSkipped.example(title: "Some Skipped Context"))
      telemetry.record(Controls::Events::ContextFinished.example)
      telemetry.record(Controls::Events::ContextSkipped.example(title: "Some Other Skipped Context"))

      context "Written Text" do
        writer = output.writer
        written_text = writer.written_text

        control_text = <<~TEXT
        \e[32mSome Context\e[0m
          \e[33mSome Skipped Context\e[0m
        \e[0m
        \e[33mSome Other Skipped Context\e[0m
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
