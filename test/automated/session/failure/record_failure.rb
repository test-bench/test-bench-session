require_relative '../../automated_init'

context "Session" do
  context "Failure" do
    context "Record Failure" do
      session = Session.new

      original_failure_sequence = session.failure_sequence
      comment "Original Failure Sequence: #{original_failure_sequence}"

      session.record_failure

      context "Failure Sequence" do
        failure_sequence = session.failure_sequence

        comment failure_sequence.inspect

        test "Incremented" do
          assert(failure_sequence == original_failure_sequence + 1)
        end
      end
    end
  end
end
