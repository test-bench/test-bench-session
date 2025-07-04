require_relative '../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Block Argument" do
      session = Session.new

      block_argument = nil

      session.evaluate(Controls::Event::Pending.example) do |arg|
        block_argument = arg
      end

      test "Is the session" do
        assert(block_argument == session)
      end
    end
  end
end
