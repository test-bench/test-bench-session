require_relative '../../../automated_init'

context "Output" do
  context "Context" do
    context "Failure" do
      context "Failure Messages" do
        output = Controls::Output.example

        telemetry = Telemetry.new
        telemetry.register(output)

        result = Controls::Result.failure

        telemetry.record(Controls::Events::ContextStarted.example)
        output.failures += 1
        telemetry.record(Controls::Events::ContextFinished.example(result:))

        telemetry.record(Controls::Events::ContextStarted.example(title: "Some Outer Context"))
        telemetry.record(Controls::Events::ContextStarted.example(title: "Some Inner Context"))
        2.times do
          output.failures += 1
        end
        telemetry.record(Controls::Events::ContextFinished.example(result:, title: "Some Inner Context"))
        telemetry.record(Controls::Events::ContextFinished.example(result:, title: "Some Outer Context"))

        context "Written Text" do
          writer = output.writer
          written_text = writer.written_text

          control_text = <<~TEXT
          Some Context

          Failure: 1

          Some Outer Context
            Some Inner Context

          Failures: 2

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
