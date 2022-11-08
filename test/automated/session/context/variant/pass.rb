require_relative '../../../automated_init'

context "Session" do
  context "Context Variant" do
    context "Pass" do
      session = Session.new

      begin
        session.context! do
          #
        end
      rescue Session::Abort => abort_exception
      end

      context "Exception" do
        test! "Not raised" do
          assert(abort_exception.nil?)
        end
      end

      context "Context Finished Event" do
        result = Controls::Result.pass

        recorded = session.telemetry.one_event?(Session::Events::ContextFinished, result:)

        test! "Recorded" do
          assert(recorded)
        end
      end

      context "Context Skipped Event" do
        recorded = session.telemetry.one_event?(Session::Events::ContextSkipped)

        test "Not recorded" do
          refute(recorded)
        end
      end
    end
  end
end
