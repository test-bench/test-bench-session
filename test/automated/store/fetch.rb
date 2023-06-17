require_relative '../automated_init'

context "Store" do
  context "Fetch" do
    context "Session Was Put" do
      store = Session::Store.new

      put_session = Session.new
      store.put(put_session)

      session = store.fetch

      test "Gets session" do
        assert(session == put_session)
      end
    end

    context "Session Wasn't Put" do
      store = Session::Store.new

      new_session = store.fetch

      test! "Gets a new session" do
        assert(new_session.instance_of?(Session))
      end

      context "New Session" do
        put = store.put?(new_session)

        test "Put" do
          assert(put)
        end
      end
    end
  end
end
