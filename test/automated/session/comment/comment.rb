require_relative '../../automated_init'

context "Session" do
  context "Comment" do
    session = Session.new

    control_text = Controls::Comment::Text.example
    control_quote = Controls::Comment::Quote.example
    control_heading = Controls::Comment::Heading.example

    session.comment(control_text, control_quote, control_heading)

    context "Commented Event" do
      commented = session.telemetry.one_event(Session::Events::Commented)

      test! "Recorded" do
        refute(commented.nil?)
      end

      context "Attributes" do
        context "Text" do
          text = commented.text

          comment text.inspect
          detail "Control: #{control_text.inspect}"

          test do
            assert(text == control_text)
          end
        end

        context "Heading" do
          heading = commented.heading

          comment heading.inspect
          detail "Control: #{control_heading.inspect}"

          test do
            assert(heading == control_heading)
          end
        end

        context "Quote" do
          quote = commented.quote

          comment quote.inspect
          detail "Control: #{control_quote.inspect}"

          test do
            assert(quote == control_quote)
          end
        end
      end
    end
  end
end
