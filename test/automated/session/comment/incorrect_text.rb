require_relative '../../automated_init'

context "Session" do
  context "Comment" do
    context "Incorrect Text" do
      text = Object.new

      session = Session.new

      quote = Controls::Comment::Quote.example

      test "Is an error" do
        assert_raises(NoMethodError) do
          session.comment(text, quote)
        end
      end
    end
  end
end
