require_relative '../../automated_init'

context "Session" do
  context "Detail" do
    session = Session.new

    control_text = Controls::Text::Detail.example
    control_disposition = Controls::CommentDisposition.example

    session.detail(control_text, control_disposition)

    context "Detailed Event" do
      detailed = session.telemetry.one_event(Events::Detailed)

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

        context "Disposition" do
          disposition = detailed.disposition

          comment disposition.inspect
          detail "Control: #{control_disposition.inspect}"

          test do
            assert(disposition == control_disposition)
          end
        end
      end
    end
  end
end
