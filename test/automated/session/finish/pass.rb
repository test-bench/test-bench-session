require_relative '../../automated_init'

context "Session" do
  context "Finish" do
    context "Pass" do
      session = Session.new

      control_process_count = Controls::Events::Finished.process_count

      session.finish(control_process_count)

      context "Finished Event" do
        result = Controls::Result.pass

        recorded = session.telemetry.one_event?(Session::Events::Finished, result:)

        test! "Recorded" do
          assert(recorded)
        end
      end
    end
  end
end
