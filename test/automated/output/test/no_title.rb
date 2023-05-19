require_relative '../../automated_init'

context "Output" do
  context "Test" do
    context "No Title" do
      output = Controls::Output.example

      telemetry = Telemetry.new
      telemetry.register(output)

      detail_text = Controls::Events::Detailed.text
      detailed = Controls::Events::Detailed.example(text: detail_text)

      comment_text = Controls::Events::Commented.text
      commented = Controls::Events::Commented.example(text: comment_text)

      telemetry.record(Controls::Events::ContextStarted.example)
      telemetry.record(Controls::Events::TestStarted::NoTitle.example)
      telemetry.record(detailed)
      telemetry.record(commented)
      telemetry.record(Controls::Events::TestFinished::NoTitle.example(result: false))
      telemetry.record(Controls::Events::ContextFinished.example)

      telemetry.record(Controls::Events::ContextStarted.example)
      telemetry.record(Controls::Events::TestStarted::NoTitle.example)
      telemetry.record(detailed)
      telemetry.record(commented)
      telemetry.record(Controls::Events::TestFinished::NoTitle.example(result: true))
      telemetry.record(Controls::Events::ContextFinished.example)

      context "Written Text" do
        writer = output.writer
        written_text = writer.written_text

        control_text = <<~TEXT
        Some Context
          Test (failed)
            #{detail_text}
            #{comment_text}

        Some Context
          #{comment_text}

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
