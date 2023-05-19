require_relative '../../../automated_init'

context "Output Branching" do
  context "Branch" do
    context "Initial Branch" do
      output = Session::Output.new

      output.branch

      context "Mode" do
        mode = output.mode

        comment mode.inspect

        test "Transitions to pending" do
          assert(output.pending?)
        end
      end

      context "Pending Writer" do
        pending_writer = output.pending_writer

        buffered_mode = !pending_writer.sync

        test "Buffered mode" do
          assert(buffered_mode)
        end
      end

      context "Passing Writer" do
        passing_writer = output.passing_writer

        test "Follows pending writer" do
          assert(passing_writer.follows?(output.pending_writer))
        end
      end

      context "Failing Writer" do
        failing_writer = output.failing_writer

        test "Follows pending writer" do
          assert(failing_writer.follows?(output.pending_writer))
        end
      end
    end
  end
end
