require_relative '../../automated_init'

context "Output" do
  context "Test" do
    context "Styling" do
      output = Controls::Output::Styling.example

      telemetry = Telemetry.new
      telemetry.register(output)

      telemetry.record(Controls::Events::TestStarted.example(title: "Some failing test"))
      telemetry.record(Controls::Events::TestFinished.example(title: "Some failing test", result: false))
      telemetry.record(Controls::Events::TestStarted.example(title: "Some passing test"))
      telemetry.record(Controls::Events::TestFinished.example(title: "Some passing test", result: true))

      context "Written Text" do
        writer = output.writer
        written_text = writer.written_text

        control_text = <<~TEXT
        \e[1;31mSome failing test\e[0m
        \e[32mSome passing test\e[0m
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
