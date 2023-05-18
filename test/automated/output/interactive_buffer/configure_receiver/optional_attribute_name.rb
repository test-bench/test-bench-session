require_relative '../../../automated_init'

context "Output" do
  context "Interactive Buffer" do
    context "Configure Receiver" do
      context "Optional Attribute Name Given" do
        attr_name = :some_other_attr
        comment "Attribute Name: #{attr_name.inspect}"

        receiver = Struct.new(attr_name).new

        Session::Output::Writer::Buffer::Interactive.configure(receiver, attr_name:)

        buffer = receiver.public_send(attr_name)

        context "Configured" do
          comment buffer.class.name

          configured = buffer.instance_of?(Session::Output::Writer::Buffer::Interactive)

          test do
            assert(configured)
          end
        end
      end
    end
  end
end
