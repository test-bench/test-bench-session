require_relative '../../automated_init'

context "Session" do
  context "Update" do
    context "Event" do
      session = Session.new

      event = Controls::Event.example
      session.update(event)

      context "Telemetry" do
        telemetry = session.telemetry

        recorded = telemetry.recorded?(event)

        test "Event is recorded" do
          assert(recorded)
        end
      end
    end

    context "Event Data" do
      session = Session.new

      control_event = Controls::Events::Commented.example

      event_data = Telemetry::Event::Export.(control_event)
      session.update(event_data)

      context "Telemetry" do
        telemetry = session.telemetry

        recorded = telemetry.recorded?(control_event)

        test "Event is recorded" do
          assert(recorded)
        end
      end
    end
  end
end
