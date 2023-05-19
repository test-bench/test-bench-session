require_relative '../../automated_init'

context "Output" do
  context "Get" do
    substitute_session = Session::Substitute.build

    result = Controls::Result.failure

    [
      Controls::Events::ContextStarted.example,
      Controls::Events::Commented.example,
      Controls::Events::Detailed.example,
      Controls::Events::TestStarted.example,
      Controls::Events::Failed.example,
      Controls::Events::TestFinished.example(result:),
      Controls::Events::ContextFinished.example(result:)
    ].each do |event|
      substitute_session.telemetry.record(event)
    end

    context "Output" do
      output = Session::Output::Get.(substitute_session, styling: false)
      control_output = <<~TEXT
      Some Context
        Some comment
        Some detail
        Some test (failed)
          Some failure message

      Failure: 1

      TEXT

      comment output
      detail "Control:", control_output

      test do
        assert(output == control_output)
      end
    end
  end
end
