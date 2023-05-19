require_relative '../../../automated_init'

context "Output Branching" do
  context "Branch" do
    output = Session::Output.new
    output.mode = Session::Output::Mode.pending

    previous_passing_writer = Session::Output::Writer.new
    output.passing_writer = previous_passing_writer

    control_branch_count = 11
    output.branch_count = control_branch_count

    output.branch

    context "Mode" do
      mode = output.mode

      comment mode.inspect

      test "Remains pending" do
        assert(output.pending?)
      end
    end

    context "Passing Writer" do
      passing_writer = output.passing_writer

      follows = passing_writer.follows?(previous_passing_writer)

      test "Follows the previous passing writer" do
        assert(follows)
      end
    end

    context "Failing Writer" do
      failing_writer = output.failing_writer

      follows = failing_writer.follows?(previous_passing_writer)

      test "Follows the previous passing writer" do
        assert(follows)
      end
    end

    context "Branch Count" do
      branch_count = output.branch_count

      comment branch_count.inspect
      detail "Control: #{control_branch_count.inspect}"

      incremented = branch_count == control_branch_count + 1

      test "Incremented" do
        assert(incremented)
      end
    end
  end
end
