require_relative '../../automated_init'

context "Session" do
  context "Detail" do
    session = Session.new

    control_text = Controls::Detail::Text.example
    control_quote = Controls::Detail::Quote.example
    control_heading = Controls::Detail::Heading.example

    session.detail(control_text, control_quote, control_heading)

    context "Detailed Event" do
      detailed = session.telemetry.one_event(Session::Events::Detailed)

      test! "Recorded" do
        refute(detailed.nil?)
      end

      context "Attributes" do
        context "Text" do
          text = detailed.text

          comment text.inspect
          detail "Control: #{control_text.inspect}"

          test do
            assert(text == control_text)
          end
        end

        context "Quote" do
          quote = detailed.quote

          comment quote.inspect
          detail "Control: #{control_quote.inspect}"

          test do
            assert(quote == control_quote)
          end
        end

        context "Heading" do
          heading = detailed.heading

          comment heading.inspect
          detail "Control: #{control_heading.inspect}"

          test do
            assert(heading == control_heading)
          end
        end
      end
    end
  end
end
