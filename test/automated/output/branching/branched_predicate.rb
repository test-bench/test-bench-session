require_relative '../../automated_init'

context "Output Branching" do
  context "Branched Predicate" do
    context "Branch Count Is Greater Than Zero" do
      branch_count = 11

      output = Session::Output.new
      output.branch_count = branch_count

      test "Branched" do
        assert(output.branched?)
      end
    end

    context "Branch Count Is Zero" do
      branch_count = 0

      output = Session::Output.new
      output.branch_count = branch_count

      test "Not branched" do
        refute(output.branched?)
      end
    end
  end
end
