require_relative '../automated_init'

context "Session" do
  context "Abort" do
    session = Session.new

    control_process_id = Controls::ProcessID.example

    session.abort(control_process_id)

    test "Failed" do
      assert(session.failed?)
    end

    context "Aborted Event" do
      aborted = session.telemetry.one_event(Session::Events::Aborted)

      test! "Recorded" do
        refute(aborted.nil?)
      end

      context "Attributes" do
        context "Abort Process ID" do
          abort_process_id = aborted.abort_process_id

          comment abort_process_id.inspect
          detail "Control: #{control_process_id.inspect}"

          test do
            assert(abort_process_id == control_process_id)
          end
        end
      end
    end
  end
end
