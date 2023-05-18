require_relative '../../../automated_init'

context "Output" do
  context "Interactive Buffer" do
    context "Configure Receiver" do
      context "Optional Device Omitted" do
        receiver = Struct.new(:buffer).new

        Session::Output::Writer::Buffer::Interactive.configure(receiver)

        buffer = receiver.buffer

        context "Device" do
          device = buffer.device

          context "Configured" do
            configured = device == Output::Writer::Defaults.device

            test do
              assert(configured)
            end
          end
        end
      end
    end
  end
end
