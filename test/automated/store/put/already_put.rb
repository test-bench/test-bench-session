require_relative '../../automated_init'

context "Store" do
  context "Put" do
    context "Already Put" do
      store = Session::Store.new

      put_session = Session.new
      store.put(put_session)

      context "Put Session" do
        session = Session.new

        test "Is an error" do
          assert_raises(Session::Store::PutError) do
            store.put(session)
          end
        end
      end
    end
  end
end
