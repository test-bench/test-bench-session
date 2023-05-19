require_relative '../../automated_init'

context "Output" do
  context "Test" do
    context "Pass" do
      result = Controls::Result.pass

      output = Controls::Output.example

      telemetry = Telemetry.new
      telemetry.register(output)

      detailed = Controls::Events::Detailed.example

      telemetry.record(Controls::Events::TestStarted.example)
      telemetry.record(detailed)
      telemetry.record(Controls::Events::TestFinished.example(result:))

      context "Written Text" do
        writer = output.writer
        written_text = writer.written_text

        control_text = "Some test\n"

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
