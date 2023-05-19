require_relative '../automated_init'

context "Output" do
  context "Failure" do
    output = Controls::Output::Styling.example

    failure_message = Controls::Events::Failed.message
    failed = Controls::Events::Failed.example(message: failure_message)

    telemetry = Telemetry.new
    telemetry.register(output)

    telemetry.record(Controls::Events::ContextStarted.example)
    telemetry.record(Controls::Events::TestStarted.example)
    telemetry.record(failed)
    telemetry.record(Controls::Events::TestFinished.example(result: false))
    telemetry.record(Controls::Events::ContextFinished.example(result: false))

    context "Written Text" do
      writer = output.writer
      written_text = writer.written_text

      control_text = <<~TEXT
      \e[32mSome Context\e[0m
        \e[1;31mSome test\e[0m
          \e[31m#{failure_message}\e[0m
      \e[0m
      \e[1;31mFailure: 1\e[0m
      \e[0m
      TEXT

      comment written_text
      detail "Control:", control_text

      test do
        assert(writer.written?(control_text))
      end
    end
  end
end
