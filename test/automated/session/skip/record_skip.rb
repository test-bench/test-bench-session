require_relative '../../automated_init'

context "Session" do
  context "Skip" do
    context "Record Skip" do
      session = Session.new

      original_skip_sequence = session.skip_sequence
      comment "Original Skip Sequence: #{original_skip_sequence}"

      session.record_skip

      context "Skip Sequence" do
        skip_sequence = session.skip_sequence

        comment skip_sequence.inspect

        test "Incremented" do
          assert(skip_sequence == original_skip_sequence + 1)
        end
      end
    end
  end
end
