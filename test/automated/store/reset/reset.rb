require_relative '../../automated_init'

context "Store" do
  context "Reset" do
    store = Session::Store.new

    session = Session.new
    store.put(session)

    store.reset

    context "Session is reset" do
      reset = !store.put?

      test do
        assert(reset)
      end
    end
  end
end
