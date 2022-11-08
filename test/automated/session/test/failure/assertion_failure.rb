require_relative '../../../automated_init'

context "Session" do
  context "Test" do
    context "Failure" do
      context "Assertion Failure" do
        session = Session.new

        control_result = Controls::Result.failure

        result = session.test do
          session.assert(false)
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
      end
    end
  end
end
