require_relative '../../automated_init'

context "Store" do
  context "Put" do
    store = Session::Store.new

    session = Session.new
    store.put(session)

    context "Put Session" do
      put_session = store.put_session

      stored = put_session.equal?(session)

      test "Stored" do
        assert(stored)
      end
    end
  end
end
