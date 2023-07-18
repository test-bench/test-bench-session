require_relative '../../../../automated_init'

context "Session" do
  context "Test Variant" do
    context "Failure" do
      context "Assertion Failure" do
        session = Session.new

        control_message = Session.abort_message
        detail "Message: #{control_message}"

        begin
          session.test! do
            session.assert(false)
          end
        rescue Session::Abort => abort_exception
        end

        context "Exception" do
          test! "Raised" do
            refute(abort_exception.nil?)
          end

          context "Message" do
            message = abort_exception.message

            comment message.inspect

            test do
              assert(message == control_message)
            end
          end
        end

        context "Failed Event" do
          recorded = session.telemetry.event?(Session::Events::Failed, message: control_message)

          test! "Not recorded" do
            refute(recorded)
          end
        end

        context "Test Finished Event" do
          recorded = session.telemetry.one_event?(Session::Events::TestFinished)

          test! "Recorded" do
            assert(recorded)
          end
        end
      end
    end
  end
end
