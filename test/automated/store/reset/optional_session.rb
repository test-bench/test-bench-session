require_relative '../../automated_init'

context "Store" do
  context "Reset" do
    context "Optional Session Given" do
      store = Session::Store.new

      put_session = Session.new
      store.put(put_session)

      session = Session.new
      store.reset(session)

      context "Session is put" do
        reset = store.put?(session)

        test do
          assert(reset)
        end
      end
    end
  end
end
