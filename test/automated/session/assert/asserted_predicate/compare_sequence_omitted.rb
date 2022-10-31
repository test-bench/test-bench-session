require_relative '../../../automated_init'

context "Session" do
  context "Assert" do
    context "Asserted Predicate" do
      context "Compare Sequence Omitted" do
        context "Assertion Sequence is Greater Than Zero" do
          session = Session.new

          session.assertion_sequence = 11

          test "Asserted" do
            assert(session.asserted?)
          end
        end

        context "Assertion Sequence is Zero" do
          session = Session.new

          session.assertion_sequence = 0

          test "Not asserted" do
            refute(session.asserted?)
          end
        end
      end
    end
  end
end
