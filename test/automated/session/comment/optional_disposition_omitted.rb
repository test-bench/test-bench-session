require_relative '../../automated_init'

context "Session" do
  context "Comment" do
    context "Optional Disposition Omitted" do
      session = Session.new

      session.comment(Controls::Text::Comment.example)

      context "Commented Event" do
        commented = session.telemetry.one_event(Events::Commented)

        test! "Recorded" do
          refute(commented.nil?)
        end

        context "Disposition Attribute" do
          disposition = commented.disposition

          comment disposition.inspect

          test "Not set" do
            assert(disposition.nil?)
          end
        end
      end
    end
  end
end
