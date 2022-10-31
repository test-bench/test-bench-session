require_relative '../../../automated_init'

context "Session" do
  context "Assert" do
    context "Asserted Predicate" do
      session = Session.new

      assertion_sequence = 11
      session.assertion_sequence = assertion_sequence

      context "Asserted" do
        context "Assertion Sequence is Greater Than The Given Sequence" do
          compare_assertion_sequence = assertion_sequence - 1

          asserted = session.asserted?(compare_assertion_sequence)

          test do
            assert(asserted)
          end
        end

        context "Assertion Sequence is Less Than The Given Sequence" do
          compare_assertion_sequence = assertion_sequence - 1

          asserted = session.asserted?(compare_assertion_sequence)

          test do
            assert(asserted)
          end
        end
      end

      context "Not Asserted" do
        context "Assertion Sequence is Equal To The Given Sequence" do
          asserted = session.asserted?(assertion_sequence)

          test do
            refute(asserted)
          end
        end
      end
    end
  end
end
