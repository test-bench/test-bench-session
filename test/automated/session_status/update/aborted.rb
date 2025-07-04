require_relative '../../automated_init'

context "Session Status" do
  context "Update" do
    context "Aborted" do
      aborted = Controls::Events::Aborted.example

      status = Status.new

      original_error_sequence = Controls::Sequence.example
      status.error_sequence = original_error_sequence

      status.update(aborted)

      context "Error Sequence" do
        error_sequence = status.error_sequence
        control_error_sequence = original_error_sequence + 1

        comment "Before: #{original_error_sequence.inspect}"
        comment "After: #{error_sequence.inspect}"
        detail "Control: #{control_error_sequence.inspect}"

        test "Incremented" do
          assert(error_sequence == control_error_sequence)
        end
      end
    end
  end
end
