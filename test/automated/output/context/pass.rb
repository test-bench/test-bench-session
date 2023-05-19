require_relative '../../automated_init'

context "Output" do
  context "Context" do
    context "Pass" do
      output = Controls::Output.example

      telemetry = Telemetry.new
      telemetry.register(output)

      result = Controls::Result.pass

      detailed = Controls::Events::Detailed.example

      telemetry.record(Controls::Events::ContextStarted.example(title: "Some Outer Context"))
      telemetry.record(detailed)
      telemetry.record(Controls::Events::ContextStarted.example(title: "Some Inner Context"))
      telemetry.record(detailed)
      telemetry.record(Controls::Events::ContextFinished.example(result:, title: "Some Inner Context"))
      telemetry.record(Controls::Events::ContextFinished.example(result:, title: "Some Outer Context"))

      context "Written Text" do
        writer = output.writer
        written_text = writer.written_text

        control_text = <<~TEXT
        Some Outer Context
          Some Inner Context

        TEXT

        comment written_text
        detail "Control:", control_text

        details_omitted = writer.written?(control_text)

        test "Details are omitted" do
          assert(details_omitted)
        end
      end
    end
  end
end
