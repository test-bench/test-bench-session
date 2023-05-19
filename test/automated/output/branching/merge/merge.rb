require_relative '../../../automated_init'

context "Output Branching" do
  context "Merge" do
    output = Session::Output.new

    previous_passing_writer, previous_failing_writer = output.writer.branch
    output.passing_writer = previous_passing_writer
    output.failing_writer = previous_failing_writer

    control_branch_count = 11
    output.branch_count = control_branch_count

    result = Controls::Result.random

    output.merge(result)

    context "Passing Writer" do
      passing_writer = output.passing_writer

      restored = previous_passing_writer.follows?(passing_writer)

      test "Restored from previous passing writer" do
        assert(restored)
      end
    end

    context "Failing Writer" do
      failing_writer = output.failing_writer

      passing_writer = output.passing_writer
      restored = previous_failing_writer.follows?(passing_writer)

      test "Restored from previous passing writer" do
        assert(restored)
      end
    end

    context "Branch Count" do
      branch_count = output.branch_count

      comment branch_count.inspect
      detail "Control: #{control_branch_count.inspect}"

      decremented = branch_count == control_branch_count - 1

      test "Decremented" do
        assert(decremented)
      end
    end
  end
end
