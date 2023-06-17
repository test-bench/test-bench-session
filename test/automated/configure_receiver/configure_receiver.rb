require_relative '../automated_init'

context "Configure Receiver" do
  attr_name = :session
  comment "Default Attribute Name: #{attr_name.inspect}"

  receiver = Struct.new(attr_name).new

  control_session = Session.new

  Session.configure(receiver, session: control_session)

  session = receiver.public_send(attr_name)

  context "Configured" do
    comment session.class.name

    configured = session == control_session

    test do
      assert(configured)
    end
  end
end
