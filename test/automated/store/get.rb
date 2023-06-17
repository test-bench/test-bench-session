require_relative '../automated_init'

context "Store" do
  context "Get" do
    context "Session Was Put" do
      store = Session::Store.new

      put_session = Session.new
      store.put(put_session)

      session = store.get

      test "Gets session" do
        assert(session.equal?(put_session))
      end
    end

    context "Session Wasn't Put" do
      store = Session::Store.new

      session = store.get

      test "Doesn't get session" do
        assert(session.nil?)
      end
    end
  end
end
