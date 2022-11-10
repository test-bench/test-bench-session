require_relative '../../automated_init'

context "Capture Sink" do
  context "Configure Receiver" do
    attr_name = :capture_sink
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Session::Telemetry::CaptureSink.configure(receiver)

    capture_sink = receiver.public_send(attr_name)

    context "Configured" do
      comment capture_sink.class.name

      configured = capture_sink.instance_of?(Session::Telemetry::CaptureSink)

      test do
        assert(configured)
      end
    end
  end
end
