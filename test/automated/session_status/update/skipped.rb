require_relative '../../automated_init'

context "Session Status" do
  context "Update" do
    context "Skipped" do
      skipped = Controls::Events::Skipped.example

      status = Status.new

      original_skip_sequence = Controls::Sequence.example
      status.skip_sequence = original_skip_sequence

      status.update(skipped)

      context "Skip Sequence" do
        skip_sequence = status.skip_sequence
        control_skip_sequence = original_skip_sequence + 1

        comment "Before: #{original_skip_sequence.inspect}"
        comment "After: #{skip_sequence.inspect}"
        detail "Control: #{control_skip_sequence.inspect}"

        test "Incremented" do
          assert(skip_sequence == control_skip_sequence)
        end
      end
    end
  end
end
