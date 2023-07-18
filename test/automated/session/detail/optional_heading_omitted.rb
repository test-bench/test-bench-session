require_relative '../../automated_init'

context "Session" do
  context "Detail" do
    context "Optional Heading Omitted" do
      session = Session.new

      text = Controls::Detail::Text.example
      quote = Controls::Detail::Quote.example

      session.detail(text, quote)

      context "Detailed Event" do
        detailed = session.telemetry.one_event(Session::Events::Detailed)

        test! "Recorded" do
          refute(detailed.nil?)
        end

        context "Heading Attribute" do
          heading = detailed.heading

          comment heading.inspect

          test "Not set" do
            assert(heading.nil?)
          end
        end
      end
    end
  end
end
