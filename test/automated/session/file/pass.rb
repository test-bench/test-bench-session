require_relative '../../automated_init'

context "Session" do
  context "File" do
    context "Pass" do
      session = Session.new

      control_result = Controls::Result.pass

      path = Controls::File::Pass.example

      result = session.file(path)

      test! do
        assert(result == control_result)
      end

      context "File Finished Event" do
        recorded = session.telemetry.one_event?(Session::Events::FileFinished, result:)

        test! "Recorded" do
          assert(recorded)
        end
      end
    end
  end
end
