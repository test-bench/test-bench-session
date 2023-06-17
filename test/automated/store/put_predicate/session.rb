require_relative '../../automated_init'

context "Store" do
  context "Put Predicate" do
    context "Session Argument Given" do
      session = Session.new

      context "Put" do
        store = Session::Store.new

        store.put(session)

        test do
          assert(store.put?(session))
        end
      end

      context "Not Put" do
        context "No Session Was Put" do
          store = Session::Store.new

          test do
            refute(store.put?(session))
          end
        end

        context "Session Doesn't Correspond" do
          other_session = Session.new

          store = Session::Store.new

          store.put(session)

          test do
            refute(store.put?(other_session))
          end
        end
      end
    end
  end
end
