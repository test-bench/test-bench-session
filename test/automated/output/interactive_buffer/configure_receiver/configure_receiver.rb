require_relative '../../../automated_init'

context "Output" do
  context "Interactive Buffer" do
    context "Configure Receiver" do
      attr_name = :buffer
      comment "Default Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      device = Controls::Output::Device.example

      Session::Output::Writer::Buffer::Interactive.configure(receiver, device:)

      buffer = receiver.public_send(attr_name)

      context "Configured" do
        comment buffer.class.name

        configured = buffer.instance_of?(Session::Output::Writer::Buffer::Interactive) &&
          buffer.device == device

        test do
          assert(configured)
        end
      end
    end
  end
end
