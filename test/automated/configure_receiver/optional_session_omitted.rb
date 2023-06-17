require_relative '../automated_init'

context "Configure Receiver" do
  context "Optional Session Omitted" do
    receiver = Struct.new(:session).new

    Session.configure(receiver)

    session = receiver.session

    context "Retrieved from store" do
      store_session = Session::Store.fetch

      retrieved = session == store_session

      test do
        assert(retrieved)
      end
    end
  end
end
