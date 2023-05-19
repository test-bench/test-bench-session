require_relative '../../automated_init'

context "Output" do
  context "Test" do
    context "Pending" do
      output = Controls::Output::Pending.example

      telemetry = Telemetry.new
      telemetry.register(output)

      detailed = Controls::Events::Detailed.example

      telemetry.record(Controls::Events::TestStarted.example)
      telemetry.record(detailed)

      context "Pending Text" do
        writer = output.pending_writer
        pending_text = writer.buffer.contents

        control_text = <<~TEXT
        \e[2mSome test\e[0m
        TEXT

        comment pending_text
        detail "Control:", control_text

        details_omitted = writer.written?(control_text)

        test "Details are omitted" do
          assert(details_omitted)
        end
      end
    end
  end
end
