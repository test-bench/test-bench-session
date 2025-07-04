require_relative '../../automated_init'

context "Session Status" do
  context "Result" do
    context "Optional Pending Event" do
      previous_status = Controls::Status::Relative.reference

      status = Controls::Status::Relative.reference
      status.test_sequence += 1

      pending_event = Controls::Events::Failed.example

      result = status.result(previous_status, pending_event)

      control_result = Result.failed

      comment result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end
  end
end
