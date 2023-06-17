require_relative '../automated_init'

context "Store" do
  context "New Session" do
    store = Session::Store.new

    new_session = store.new_session

    context "Telemetry Sinks" do
      telemetry_sinks = new_session.telemetry.sinks

      context! "One Sink" do
        count = telemetry_sinks.count

        comment count.inspect

        test do
          assert(count == 1)
        end
      end

      context "Sink" do
        telemetry_sink = telemetry_sinks[0]

        test "Session output" do
          assert(telemetry_sink.instance_of?(Session::Output))
        end
      end
    end
  end
end
