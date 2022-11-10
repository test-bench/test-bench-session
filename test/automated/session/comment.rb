require_relative '../automated_init'

context "Session" do
  context "Comment" do
    session = Session.new

    control_text = Controls::Comment::Text.example

    session.comment(control_text)

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
      end
    end
  end
end
