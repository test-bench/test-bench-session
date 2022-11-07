require_relative '../../../automated_init'

context "Session" do
  context "Failure" do
    context "Fail" do
      context "No Message" do
        session = Session.new

        default_message = Session.default_failure_message
        detail "Default Message: #{default_message}"

        begin
          session.fail
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
              assert(message == default_message)
            end
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
              assert(message == default_message)
            end
          end
        end
      end
    end
  end
end
