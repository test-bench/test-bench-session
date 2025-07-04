require_relative '../../automated_init'

context "Session" do
  context "Skip" do
    session = Session.new

    control_message = Controls::Message::Skip.example
    session.skip(control_message)

    context "Skipped Event" do
      skipped = session.telemetry.one_event(Events::Skipped)

      test! "Recorded" do
        refute(skipped.nil?)
      end

      context "Message Attribute" do
        message = skipped.message

        comment message.inspect
        detail "Control: #{control_message.inspect}"

        test do
          assert(message == control_message)
        end
      end
    end
  end
end
