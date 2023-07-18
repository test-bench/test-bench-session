require_relative '../../automated_init'

context "Session" do
  context "Comment" do
    context "Optional Heading Omitted" do
      session = Session.new

      text = Controls::Comment::Text.example
      quote = Controls::Comment::Quote.example

      session.comment(text, quote)

      context "Commented Event" do
        commented = session.telemetry.one_event(Session::Events::Commented)

        test! "Recorded" do
          refute(commented.nil?)
        end

        context "Heading Attribute" do
          heading = commented.heading

          comment heading.inspect

          test "Not set" do
            assert(heading.nil?)
          end
        end
      end
    end
  end
end
