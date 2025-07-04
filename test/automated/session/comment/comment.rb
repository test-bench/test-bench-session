require_relative '../../automated_init'

context "Session" do
  context "Comment" do
    session = Session.new

    control_text = Controls::Text::Comment.example
    control_disposition = Controls::CommentDisposition.example

    session.comment(control_text, control_disposition)

    context "Commented Event" do
      commented = session.telemetry.one_event(Events::Commented)

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

        context "Disposition" do
          disposition = commented.disposition

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
