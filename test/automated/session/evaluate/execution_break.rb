require_relative '../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Execution Break" do
      session = Session.new

      test "Caught" do
        refute_raises(UncaughtThrowError) do
          session.evaluate(Controls::Event::Pending.example) do
            throw ExecutionBreak
          end
        end
      end
    end
  end
end
