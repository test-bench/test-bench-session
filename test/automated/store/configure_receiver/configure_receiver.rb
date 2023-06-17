require_relative '../../automated_init'

context "Store" do
  context "Configure Receiver" do
    attr_name = :session_store
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Session::Store.configure(receiver)

    session_store = receiver.public_send(attr_name)

    context "Configured" do
      configured = session_store == Session::Store.instance

      test do
        assert(configured)
      end
    end
  end
end
