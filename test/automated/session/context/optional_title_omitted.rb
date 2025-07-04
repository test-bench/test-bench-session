require_relative '../../automated_init'

context "Session" do
  context "Context" do
    context "Optional Title Omitted" do
      session = Session.new

      session.context {}

      context "Context Started Event" do
        context_started = session.telemetry.one_event(Events::ContextStarted)

        context "Title Attribute" do
          title = context_started.title

          test "Not set" do
            assert(title.nil?)
          end
        end
      end

      context "Context Finished Event" do
        context_finished = session.telemetry.one_event(Events::ContextFinished)

        context "Title Attribute" do
          title = context_finished.title

          test "Not set" do
            assert(title.nil?)
          end
        end
      end
    end
  end
end
