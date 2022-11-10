require_relative '../../automated_init'

context "Session" do
  context "Context" do
    context "Context Skipped" do
      session = Session.new

      control_title = Controls::Title::Context.example

      session.context(control_title)

      context "Context Skipped Event" do
        context_skipped = session.telemetry.one_event(Session::Events::ContextSkipped)

        test! "Recorded" do
          refute(context_skipped.nil?)
        end

        context "Attributes" do
          context "Title" do
            title = context_skipped.title

            comment title.inspect
            detail "Control: #{control_title.inspect}"

            test do
              assert(title == control_title)
            end
          end
        end
      end

      context "Context Started Event" do
        recorded = session.telemetry.event?(Session::Events::ContextStarted)

        test "Not recorded" do
          refute(recorded)
        end
      end

      context "Context Finished Event" do
        recorded = session.telemetry.event?(Session::Events::ContextFinished)

        test "Not recorded" do
          refute(recorded)
        end
      end
    end
  end
end
