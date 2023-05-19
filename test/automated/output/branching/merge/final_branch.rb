require_relative '../../../automated_init'

context "Output Branching" do
  context "Merge" do
    context "Final Branch" do
      output = Session::Output.new
      output.mode = Session::Output::Mode.pending

      output.branch

      result = Controls::Result.random

      output.merge(result)

      context "Mode" do
        mode = output.mode

        comment mode.inspect

        test "Transitions to initial" do
          assert(output.initial?)
        end
      end

      context "Pending Writer" do
        pending_writer = output.pending_writer

        synchronous_mode = pending_writer.sync

        test "Synchronous mode is restored" do
          assert(synchronous_mode)
        end
      end
    end
  end
end
