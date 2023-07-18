require_relative '../../../automated_init'

context "Session" do
  context "Failure" do
    context "Failed Predicate" do
      session = Session.new

      failure_sequence = 11
      session.failure_sequence = failure_sequence

      context "Failed" do
        context "Failure Sequence is Greater Than The Given Sequence" do
          compare_failure_sequence = failure_sequence - 1

          failed = session.failed?(compare_failure_sequence)

          test do
            assert(failed)
          end
        end

        context "Failure Sequence is Less Than The Given Sequence" do
          compare_failure_sequence = failure_sequence - 1

          failed = session.failed?(compare_failure_sequence)

          test do
            assert(failed)
          end
        end
      end

      context "Not Failed" do
        context "Failure Sequence is Equal To The Given Sequence" do
          failed = session.failed?(failure_sequence)

          test do
            refute(failed)
          end
        end
      end
    end
  end
end
