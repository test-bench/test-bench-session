require_relative '../../../automated_init'

context "Output" do
  context "Context" do
    context "Failure" do
      context "Details" do
        output = Controls::Output.example

        telemetry = Telemetry.new
        telemetry.register(output)

        result = Controls::Result.failure

        detail_text = Controls::Events::Detailed.text
        detailed = Controls::Events::Detailed.example(text: detail_text)

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
            #{detail_text}
            Some Inner Context
              #{detail_text}

          TEXT

          comment written_text
          detail "Control:", control_text

          details_included = writer.written?(control_text)

          test "Details are included" do
            assert(details_included)
          end
        end
      end
    end
  end
end
