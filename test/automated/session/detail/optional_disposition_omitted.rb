require_relative '../../automated_init'

context "Session" do
  context "Detail" do
    context "Optional Disposition Omitted" do
      session = Session.new

      session.detail(Controls::Text::Detail.example)

      context "Commented Event" do
        detailed = session.telemetry.one_event(Events::Detailed)

        test! "Recorded" do
          refute(detailed.nil?)
        end

        context "Disposition Attribute" do
          disposition = detailed.disposition

          comment disposition.inspect

          test "Not set" do
            assert(disposition.nil?)
          end
        end
      end
    end
  end
end
