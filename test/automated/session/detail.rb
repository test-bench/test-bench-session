require_relative '../automated_init'

context "Session" do
  context "Detail" do
    session = Session.new

    control_text = Controls::Detail::Text.example

    session.detail(control_text)

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
      end
    end
  end
end
