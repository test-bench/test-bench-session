require_relative '../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Failed" do
      session = Session.new

      pending_event = Controls::Event::Pending.example

      message = Controls::Message::Failure.example

      evaluate_result = session.evaluate(pending_event) do
        raise Failure, message
      end

      context "Result" do
        control_result = Result.failed

        comment evaluate_result.inspect
        detail "Control: #{control_result.inspect}"

        test do
          assert(evaluate_result == control_result)
        end
      end

      context "Failed Event" do
        recorded = session.telemetry.event?(Events::Failed, message:)

        test "Recorded" do
          assert(recorded)
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
