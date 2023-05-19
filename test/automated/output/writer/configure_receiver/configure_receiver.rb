require_relative '../../../automated_init'

context "Output" do
  context "Writer" do
    context "Configure Receiver" do
      attr_name = :writer
      comment "Default Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      device = Controls::Output::Device.example
      styling = Controls::Output::Styling.random

      Session::Output::Writer.configure(receiver, device:, styling:)

      writer = receiver.public_send(attr_name)

      context "Configured" do
        comment writer.class.name

        configured = writer.instance_of?(Session::Output::Writer) &&
          writer.device == device &&
          writer.alternate_device.instance_of?(Output::Device::Null) &&
          writer.styling == styling &&
          writer.buffer.limit == 0

        test do
          assert(configured)
        end
      end
    end
  end
end
