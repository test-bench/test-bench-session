require_relative '../../automated_init'

context "Session" do
  context "Test" do
    context "No Assertion" do
      session = Session.new

      result = session.test(Controls::Title::Test.example) {}

      context "Result" do
        control_result = Result.failed

        comment result.inspect
        detail "Control: #{control_result.inspect}"

        test do
          assert(result == control_result)
        end
      end

      context "Failed Event" do
        failed = session.telemetry.one_event(Events::Failed)

        test! "Recorded" do
          refute(failed.nil?)
        end

        context "Message Attribute" do
          message = failed.message
          control_message = "Test didn't perform an assertion"

          comment message.inspect
          detail "Control: #{control_message.inspect}"

          test do
            assert(message == control_message)
          end
        end
      end
    end
  end
end
