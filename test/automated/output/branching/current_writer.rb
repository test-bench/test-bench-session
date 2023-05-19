require_relative '../../automated_init'

context "Output Branching" do
  context "Current Writer" do
    output = Session::Output.new

    pending_writer = output.pending_writer

    passing_writer = Session::Output::Writer.new
    output.passing_writer = passing_writer

    failing_writer = Session::Output::Writer.new
    output.failing_writer = failing_writer

    context "Mode: Initial" do
      output.mode = Session::Output::Mode.initial

      writer = output.writer

      test "Pending writer" do
        assert(writer == pending_writer)
      end
    end

    context "Mode: Pending" do
      output.mode = Session::Output::Mode.pending

      writer = output.writer

      test "Pending writer" do
        assert(writer == pending_writer)
      end
    end

    context "Mode: Passing" do
      output.mode = Session::Output::Mode.passing

      writer = output.writer

      test "Passing writer" do
        assert(writer == passing_writer)
      end
    end

    context "Mode: Failing" do
      output.mode = Session::Output::Mode.failing

      writer = output.writer

      test "Failing writer" do
        assert(writer == failing_writer)
      end
    end
  end
end
