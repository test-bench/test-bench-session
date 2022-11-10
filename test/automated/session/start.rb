require_relative '../automated_init'

context "Session" do
  context "Start" do
    session = Session.new

    control_process_count = Controls::Events::Started.process_count

    session.start(control_process_count)

    context "Started Event" do
      started = session.telemetry.one_event(Session::Events::Started)

      test! "Recorded" do
        refute(started.nil?)
      end

      context "Attributes" do
        context "Process Count" do
          process_count = started.process_count

          comment process_count.inspect
          detail "Control: #{control_process_count.inspect}"

          test do
            assert(process_count == control_process_count)
          end
        end
      end
    end
  end
end
