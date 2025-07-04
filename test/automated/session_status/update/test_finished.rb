require_relative '../../automated_init'

context "Session Status" do
  context "Update" do
    context "Test Finished" do
      test_finished = Controls::Events::TestFinished.example

      status = Status.new

      original_test_sequence = Controls::Sequence.example
      status.test_sequence = original_test_sequence

      status.update(test_finished)

      context "Test Sequence" do
        test_sequence = status.test_sequence
        control_test_sequence = original_test_sequence + 1

        comment "Before: #{original_test_sequence.inspect}"
        comment "After: #{test_sequence.inspect}"
        detail "Control: #{control_test_sequence.inspect}"

        test "Incremented" do
          assert(test_sequence == control_test_sequence)
        end
      end
    end
  end
end
