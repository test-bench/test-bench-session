require_relative '../../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Passed" do
      session = Session.new

      pending_event = Controls::Event::Pending.example

      evaluate_result = session.evaluate(pending_event) do
        session.status = Controls::Status::Passed.example
      end

      context "Result" do
        control_result = Result.passed

        comment evaluate_result.inspect
        detail "Control: #{control_result.inspect}"

        test do
          assert(evaluate_result == control_result)
        end
      end

      context "Pending Event" do
        test "Recorded" do
          assert(session.telemetry.recorded?(pending_event))
        end

        context "Result Attribute" do
          result = pending_event.result

          comment result.inspect
          detail "Evaluate Result: #{evaluate_result.inspect}"

          test do
            assert(result == evaluate_result)
          end
        end
      end
    end
  end
end
