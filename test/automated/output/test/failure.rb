require_relative '../../automated_init'

context "Output" do
  context "Test" do
    context "Failure" do
      result = Controls::Result.failure

      output = Controls::Output.example

      telemetry = Telemetry.new
      telemetry.register(output)

      detail_text = Controls::Events::Detailed.text
      detailed = Controls::Events::Detailed.example(text: detail_text)

      telemetry.record(Controls::Events::TestStarted.example)
      telemetry.record(detailed)
      telemetry.record(Controls::Events::TestFinished.example(result:))

      context "Written Text" do
        writer = output.writer
        written_text = writer.written_text

        control_text = <<~TEXT
        Some test (failed)
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
