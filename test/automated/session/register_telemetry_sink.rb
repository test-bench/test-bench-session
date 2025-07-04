require_relative '../automated_init'

context "Session" do
  context "Register Telemetry Sink" do
    telemetry_sink = Controls::TelemetrySink.example

    session = Session.new

    session.register_telemetry_sink(telemetry_sink)

    telemetry = session.telemetry

    test "Registered" do
      assert(telemetry.registered?(telemetry_sink))
    end
  end
end
