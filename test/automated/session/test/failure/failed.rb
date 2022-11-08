require_relative '../../../automated_init'

context "Session" do
  context "Test" do
    context "Failure" do
      context "Failed" do
        session = Session.new

        control_result = Controls::Result.failure

        result = session.test(__FILE__, __LINE__) do
          session.record_failure
        end

        test! do
          assert(result == control_result)
        end

        context "Test Finished Event" do
          recorded = session.telemetry.one_event?(Session::Events::TestFinished, result:)

          test! "Recorded" do
            assert(recorded)
          end
        end

        context "Test Skipped Event" do
          recorded = session.telemetry.event?(Session::Events::TestSkipped)

          test "Not recorded" do
            refute(recorded)
          end
        end

        context "Failed Event" do
          recorded = session.telemetry.event?(Session::Events::Failed)

          test "Not recorded" do
            refute(recorded)
          end
        end
      end
    end
  end
end
