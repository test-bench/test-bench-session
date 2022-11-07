require_relative '../../../automated_init'

context "Session" do
  context "Failure" do
    context "Fail" do
      session = Session.new

      control_message = Controls::Failure::Message.example
      detail "Message: #{control_message}"

      begin
        session.fail(control_message)
      rescue Session::Failure => failure
      end

      context "Exception" do
        test! "Raised" do
          refute(failure.nil?)
        end

        context "Message" do
          message = failure.message

          comment message.inspect

          test do
            assert(message == control_message)
          end
        end
      end

      context "Session" do
        failed = session.failed?

        test "Failed" do
          assert(failed)
        end
      end

      context "Failed Event" do
        failed = session.telemetry.one_event(Session::Events::Failed)

        test! "Recorded" do
          refute(failed.nil?)
        end

        context "Message" do
          message = failed.message

          comment message.inspect

          test do
            assert(message == control_message)
          end
        end
      end
    end
  end
end
