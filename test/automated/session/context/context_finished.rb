require_relative '../../automated_init'

context "Session" do
  context "Context" do
    context "Context Finished Event" do
      session = Session.new

      control_title = Controls::Title::Context.example

      session.context(control_title) do
        #
      end

      context "Context Finished Event" do
        context_finished = session.telemetry.one_event(Session::Events::ContextFinished)

        test! "Recorded" do
          refute(context_finished.nil?)
        end

        context "Attributes" do
          context "Title" do
            title = context_finished.title

            comment title.inspect
            detail "Control: #{control_title.inspect}"

            test do
              assert(title == control_title)
            end
          end

          context "Result" do
            result = context_finished.result

            comment result.inspect

            test "Set" do
              refute(result.nil?)
            end
          end
        end
      end
    end
  end
end
