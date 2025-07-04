require_relative '../../automated_init'

context "Session" do
  context "Skip" do
    context "Optional Title Omitted" do
      session = Session.new

      session.skip

      context "Skipped Event" do
        skipped = session.telemetry.one_event(Events::Skipped)

        test! "Recorded" do
          refute(skipped.nil?)
        end

        context "Message Attribute" do
          message = skipped.message

          test "Not set" do
            assert(message.nil?)
          end
        end
      end
    end
  end
end
