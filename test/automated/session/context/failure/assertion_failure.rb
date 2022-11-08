require_relative '../../../automated_init'

context "Session" do
  context "Context" do
    context "Failure" do
      context "Assertion Failure" do
        session = Session.new

        control_result = Controls::Result.failure

        result = session.context do
          session.assert(false, __FILE__, __LINE__)
        end

        test! do
          assert(result == control_result)
        end

        context "Context Finished Event" do
          recorded = session.telemetry.one_event?(Session::Events::ContextFinished, result: control_result)

          test! "Recorded" do
            assert(recorded)
          end
        end
      end
    end
  end
end
