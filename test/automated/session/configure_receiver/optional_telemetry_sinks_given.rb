require_relative '../../automated_init'

context "Session" do
  context "Configure Receiver" do
    context "Optional Telemetry Sinks Given" do
      sink_1 = Telemetry::Controls::Sink.example
      sink_2 = Telemetry::Controls::Sink.example

      receiver = Struct.new(:test_session).new

      Session.configure(receiver, sink_1, sink_2)

      telemetry = receiver.test_session.telemetry

      context "First Sink" do
        registered = telemetry.registered?(sink_1)

        test "Registered" do
          assert(registered)
        end
      end

      context "Second Sink" do
        registered = telemetry.registered?(sink_2)

        test "Registered" do
          assert(registered)
        end
      end
    end
  end
end
