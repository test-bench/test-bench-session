require_relative '../../automated_init'

context "Session" do
  context "Assert" do
    context "Record Assertion" do
      session = Session.new

      original_assertion_sequence = session.assertion_sequence
      comment "Original Assertion Sequence: #{original_assertion_sequence}"

      session.record_assertion

      context "Assertion Sequence" do
        assertion_sequence = session.assertion_sequence

        comment assertion_sequence.inspect

        test "Incremented" do
          assert(assertion_sequence == original_assertion_sequence + 1)
        end
      end
    end
  end
end
