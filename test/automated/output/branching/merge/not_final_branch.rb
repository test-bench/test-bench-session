require_relative '../../../automated_init'

context "Output Branching" do
  context "Merge" do
    context "Not Final Branch" do
      output = Session::Output.new

      2.times do
        output.branch
      end

      result = Controls::Result.random

      output.merge(result)

      context "Mode" do
        mode = output.mode

        comment mode.inspect

        test "Remains pending" do
          assert(output.pending?)
        end
      end

      context "Pending Writer" do
        pending_writer = output.pending_writer

        buffered_mode = !pending_writer.sync

        test "Remains in buffered mode" do
          assert(buffered_mode)
        end
      end
    end
  end
end
