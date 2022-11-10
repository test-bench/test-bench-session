require_relative '../../automated_init'

context "Session" do
  context "Configure Receiver" do
    context "Optional Attribute Name Given" do
      attr_name = :some_other_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      Session.configure(receiver, attr_name:)

      session = receiver.public_send(attr_name)

      context "Configured" do
        comment session.class.name

        configured = session.instance_of?(Session)

        test do
          assert(configured)
        end
      end
    end
  end
end
