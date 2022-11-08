require_relative '../../automated_init'

context "Session" do
  context "Skip" do
    context "Skipped Predicate" do
      context "Skip Sequence is Greater Than Zero" do
        session = Session.new

        session.skip_sequence = 11

        test "Skipped" do
          assert(session.skipped?)
        end
      end

      context "Skip Sequence is Zero" do
        session = Session.new

        session.skip_sequence = 0

        test "Not skipped" do
          refute(session.skipped?)
        end
      end
    end
  end
end
