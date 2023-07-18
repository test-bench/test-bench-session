require_relative '../../automated_init'

context "Session" do
  context "Test" do
    context "Incorrect Title" do
      session = Session.new

      title = Object.new

      test "Is an error" do
        assert_raises(NoMethodError) do
          session.test(title) do
            #
          end
        end
      end
    end
  end
end
