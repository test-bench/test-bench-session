require_relative '../../automated_init'

context "Output" do
  context "Get" do
    context "Session" do
      session = Session.new

      test "Is an error" do
        assert_raises do
          Session::Output::Get.(session)
        end
      end
    end
  end
end
