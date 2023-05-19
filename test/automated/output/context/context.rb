require_relative '../../automated_init'

context "Output" do
  context "Context" do
    output = Controls::Output.example

    telemetry = Telemetry.new
    telemetry.register(output)

    telemetry.record(Controls::Events::ContextStarted.example(title: "Some Outer Context"))
    telemetry.record(Controls::Events::ContextStarted.example(title: "Some Inner Context"))
    telemetry.record(Controls::Events::ContextFinished.example(title: "Some Inner Context"))
    telemetry.record(Controls::Events::ContextStarted.example(title: "Some Other Inner Context"))
    telemetry.record(Controls::Events::ContextFinished.example(title: "Some Other Inner Context"))
    telemetry.record(Controls::Events::ContextFinished.example(title: "Some Outer Context"))
    telemetry.record(Controls::Events::ContextStarted.example(title: "Some Other Outer Context"))
    telemetry.record(Controls::Events::ContextFinished.example(title: "Some Other Outer Context"))

    context "Written Text" do
      writer = output.writer
      written_text = writer.written_text

      control_text = <<~TEXT
      Some Outer Context
        Some Inner Context
        Some Other Inner Context

      Some Other Outer Context

      TEXT

      comment written_text
      detail "Control:", control_text

      details_omitted = writer.written?(control_text)

      test do
        assert(details_omitted)
      end
    end

    context "Mode" do
      mode = output.mode

      comment mode.inspect

      test "Initial mode is restored" do
        assert(output.initial?)
      end
    end
  end
end
