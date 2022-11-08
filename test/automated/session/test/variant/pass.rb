require_relative '../../../automated_init'

context "Session" do
  context "Test Variant" do
    context "Pass" do
      session = Session.new

      begin
        session.test!(__FILE__, __LINE__) do
          session.record_assertion
        end
      rescue Session::Abort => abort_exception
      end

      context "Exception" do
        test! "Not raised" do
          assert(abort_exception.nil?)
        end
      end

      context "Test Finished Event" do
        result = Controls::Result.pass

        recorded = session.telemetry.one_event?(Session::Events::TestFinished, result:)

        test! "Recorded" do
          assert(recorded)
        end
      end

      context "Test Skipped Event" do
        recorded = session.telemetry.event?(Session::Events::TestSkipped)

        test "Not recorded" do
          refute(recorded)
        end
      end
    end
  end
end
