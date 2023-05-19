require_relative '../../automated_init'

context "Output" do
  context "Configure Buffer" do
    context "Optional Device Omitted" do
      receiver = Struct.new(:buffer).new

      Session::Output::Writer::Buffer.configure(receiver)

      buffer = receiver.buffer

      context "Configured" do
        comment buffer.class.name

        configured = !buffer.nil?

        test do
          assert(configured)
        end
      end
    end
  end
end
