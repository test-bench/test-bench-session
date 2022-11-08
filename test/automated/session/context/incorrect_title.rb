require_relative '../../automated_init'

context "Session" do
  context "Context" do
    context "Incorrect Title" do
      session = Session.new

      title = Object.new

      test "Is an error" do
        assert_raises(NoMethodError) do
          session.context(title) do
            #
          end
        end
      end
    end
  end
end
