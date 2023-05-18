require_relative '../../automated_init'

context "Output" do
  context "Configure Buffer" do
    attr_name = :buffer
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver_class = Struct.new(attr_name)

    context "Device Is a TTY" do
      device = Controls::Output::Device::TTY.example

      context "Experimental Output Activated" do
        experimental_output = true

        receiver = receiver_class.new

        Session::Output::Writer::Buffer.configure(receiver, device:, experimental_output:)

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

      context "Experimental Output Deacivated" do
        experimental_output = false

        receiver = receiver_class.new

        Session::Output::Writer::Buffer.configure(receiver, device:, experimental_output:)

        buffer = receiver.public_send(attr_name)

        context "Configured" do
          comment buffer.class.name

          configured = buffer.instance_of?(Output::Writer::Buffer) &&
            buffer.limit.zero?

          test do
            assert(configured)
          end
        end
      end
    end

    context "Device Isn't a TTY" do
      device = Controls::Output::Device::TTY::Non.example

      receiver = receiver_class.new

      Session::Output::Writer::Buffer.configure(receiver, device:)

      buffer = receiver.public_send(attr_name)

      context "Configured" do
        comment buffer.class.name

        configured = buffer.instance_of?(Output::Writer::Buffer) &&
          buffer.limit.zero?

        test do
          assert(configured)
        end
      end
    end
  end
end
