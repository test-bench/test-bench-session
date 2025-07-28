require_relative '../../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Passed" do
      context "Prior Failure" do
        session = Session.new

        status = Controls::Status::Failed.example

        session.status = status

        evaluate_result = session.evaluate(Controls::Event::Pending.example) do
          status.test_sequence += 1
        end

        context "Result" do
          control_result = Result.passed

          comment evaluate_result.inspect
          detail "Control: #{control_result.inspect}"

          test do
            assert(evaluate_result == control_result)
          end
        end
      end
    end
  end
end
