require_relative '../../../automated_init'

context "Session" do
  context "Context" do
    context "Failure" do
      context "Failed" do
        session = Session.new

        control_result = Controls::Result.failure

        result = session.context do
          session.record_failure
        end

        test! do
          assert(result == control_result)
        end

        context "Context Finished Event" do
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
      end
    end
  end
end
