require_relative '../../automated_init'

context "Store" do
  context "Configure Receiver" do
    context "Optional Attribute Name" do
      attr_name = :some_other_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      Session::Store.configure(receiver, attr_name:)

      session_store = receiver.public_send(attr_name)

      context "Configured" do
        configured = session_store.instance_of?(Session::Store)

        test do
          assert(configured)
        end
      end
    end
  end
end
