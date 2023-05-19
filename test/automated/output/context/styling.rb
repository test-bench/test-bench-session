require_relative '../../automated_init'

context "Output" do
  context "Context" do
    context "Styling" do
      output = Controls::Output::Styling.example

      telemetry = Telemetry.new
      telemetry.register(output)

      telemetry.record(Controls::Events::ContextStarted.example)
      telemetry.record(Controls::Events::ContextFinished.example)

      context "Written Text" do
        writer = output.writer
        written_text = writer.written_text

        control_text = <<~TEXT
        \e[32mSome Context\e[0m
        \e[0m
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
end
