require_relative '../../automated_init'

context "Output" do
  context "Get" do
    context "Styling" do
      events = [
        Controls::Events::ContextStarted.example,
        Controls::Events::ContextFinished.example
      ]

      context "Enabled (default)" do
        substitute_session = Session::Substitute.build
        events.each do |event|
          substitute_session.telemetry.record(event)
        end

        context "Output" do
          output = Session::Output::Get.(substitute_session)
          control_output = <<~TEXT
          \e[32mSome Context\e[0m
          \e[0m
          TEXT

          comment output
          detail "Control:", control_output

          test do
            assert(output == control_output)
          end
        end
      end

      context "Disabled" do
        styling = false

        substitute_session = Session::Substitute.build
        events.each do |event|
          substitute_session.telemetry.record(event)
        end

        context "Output" do
          output = Session::Output::Get.(substitute_session, styling:)
          control_output = <<~TEXT
          Some Context

          TEXT

          comment output
          detail "Control:", control_output

          test do
            assert(output == control_output)
          end
        end
      end
    end
  end
end
