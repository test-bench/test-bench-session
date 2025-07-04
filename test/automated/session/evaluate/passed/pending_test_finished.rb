require_relative '../../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Passed" do
      context "Test Finished Is Pending Event" do
        session = Session.new

        pending_test_finished = Events::TestFinished.new

        result = session.evaluate(pending_test_finished) {}

        context "Result" do
          control_result = Result.passed

          comment result.inspect
          detail "Control: #{control_result.inspect}"

          test do
            assert(result == control_result)
          end
        end
      end
    end
  end
end
