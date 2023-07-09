require_relative '../../../../automated_init'

context "Session" do
  context "Test Variant" do
    context "Failure" do
      context "Failed" do
        session = Session.new

        control_message = Session.abort_message
        detail "Message: #{control_message}"

        begin
          session.test! do
            session.record_failure
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

        context "Test Skipped Event" do
          recorded = session.telemetry.event?(Session::Events::TestSkipped)

          test "Not recorded" do
            refute(recorded)
          end
        end

        context "Failed Event" do
          recorded = session.telemetry.event?(Session::Events::Failed, message: control_message)

          test! "Not recorded" do
            refute(recorded)
          end
        end

        context "Test Finished Event" do
          result = Controls::Result.failure

          recorded = session.telemetry.one_event?(Session::Events::TestFinished, result:)

          test! "Recorded" do
            assert(recorded)
          end
        end
      end
    end
  end
end
