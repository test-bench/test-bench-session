require_relative '../../automated_init'

context "Session Status" do
  context "Update" do
    context "Failed" do
      failed = Controls::Events::Failed.example

      status = Status.new

      original_failure_sequence = Controls::Sequence.example
      status.failure_sequence = original_failure_sequence

      status.update(failed)

      context "Failed Sequence" do
        failure_sequence = status.failure_sequence
        control_failure_sequence = original_failure_sequence + 1

        comment "Before: #{original_failure_sequence.inspect}"
        comment "After: #{failure_sequence.inspect}"
        detail "Control: #{control_failure_sequence.inspect}"

        test "Incremented" do
          assert(failure_sequence == control_failure_sequence)
        end
      end
    end
  end
end
