require_relative '../../automated_init'

context "Session" do
  context "Assert" do
    context "Pass" do
      session = Session.new

      result = Controls::Result.pass

      path = Controls::Failure::Path.example
      line_number = Controls::Failure::LineNumber.example

      begin
        session.assert(result, path, line_number)
      rescue Session::Failure => failure
      end

      test "No exception raised" do
        assert(failure.nil?)
      end

      context "Session" do
        asserted = session.asserted?

        test "Asserted" do
          assert(asserted)
        end
      end

      context "Failed Event" do
        recorded = session.telemetry.event?(Session::Events::Failed)

        test "Not recorded" do
          refute(recorded)
        end
      end
    end
  end
end
