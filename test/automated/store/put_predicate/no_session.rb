require_relative '../../automated_init'

context "Store" do
  context "Put Predicate" do
    context "No Session Argument" do
      context "Session Was Put" do
        store = Session::Store.new

        session = Session.new
        store.put(session)

        test "Put" do
          assert(store.put?)
        end
      end

      context "Session Wasn't Put" do
        store = Session::Store.new

        test "Put" do
          refute(store.put?)
        end
      end
    end
  end
end
