require_relative '../../../automated_init'

context "Session" do
  context "Failure" do
    context "Failed Predicate" do
      context "Compare Sequence Omitted" do
        context "Failure Sequence is Greater Than Zero" do
          session = Session.new

          session.failure_sequence = 11

          test "Failed" do
            assert(session.failed?)
          end
        end

        context "Failure Sequence is Zero" do
          session = Session.new

          session.failure_sequence = 0

          test "Not failed" do
            refute(session.failed?)
          end
        end
      end
    end
  end
end
