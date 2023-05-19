require_relative '../../automated_init'

context "Output" do
  context "Test" do
    output = Controls::Output.example

    telemetry = Telemetry.new
    telemetry.register(output)

    telemetry.record(Controls::Events::TestStarted.example(title: "Some test"))
    telemetry.record(Controls::Events::Commented.example(text: "Some comment"))
    telemetry.record(Controls::Events::TestFinished.example(title: "Some test"))

    context "Written Text" do
      writer = output.writer
      written_text = writer.written_text

      control_text = <<~TEXT
      Some test
        Some comment
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
