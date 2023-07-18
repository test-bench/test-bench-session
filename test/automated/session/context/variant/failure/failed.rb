require_relative '../../../../automated_init'

context "Session" do
  context "Context Variant" do
    context "Failure" do
      context "Failed" do
        session = Session.new

        control_message = Session.abort_message
        detail "Message: #{control_message}"

        begin
          session.context! do
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

        context "Context Finished Event" do
          result = Controls::Result.failure

          recorded = session.telemetry.one_event?(Session::Events::ContextFinished, result:)

          test! "Recorded" do
            assert(recorded)
          end
        end

        context "Context Skipped Event" do
          recorded = session.telemetry.event?(Session::Events::ContextSkipped)

          test "Not recorded" do
            refute(recorded)
          end
        end

        context "Failed Event" do
          recorded = session.telemetry.event?(Session::Events::Failed)

          test! "Not recorded" do
            refute(recorded)
          end
        end
      end
    end
  end
end
