require_relative '../../automated_init'

context "Session" do
  context "Assert" do
    context "Failure" do
      session = Session.new

      control_result = Controls::Result.failure

      control_message = Session.assertion_failure_message

      begin
        session.assert(control_result)
      rescue Session::Failure => failure
      end

      context "Exception" do
        test! "Raised" do
          refute(failure.nil?)
        end

        context "Message" do
          message = failure.message

          comment message.inspect
          detail "Control: #{control_message}"

          test do
            assert(message == control_message)
          end
        end
      end

      context "Session" do
        asserted = session.asserted?

        test "Asserted" do
          assert(asserted)
        end
      end

      context "Failed Event" do
        failed = session.telemetry.one_event(Session::Events::Failed)

        test! "Recorded" do
          refute(failed.nil?)
        end

        context "Attributes" do
          context "Message" do
            message = failed.message

            comment message.inspect
            detail "Control: #{control_message}"

            test do
              assert(message == control_message)
            end
          end
        end
      end
    end
  end
end
