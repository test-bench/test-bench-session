require_relative '../../../automated_init'

context "Session" do
  context "Context Variant" do
    context "Optional Title Omitted" do
      session = Session.new

      begin
        session.context! do
          #
        end
      rescue Session::Abort
      end

      context "Context Started Event" do
        context_started = session.telemetry.one_event(Session::Events::ContextStarted)

        test! "Recorded" do
          refute(context_started.nil?)
        end

        context "Title Attribute" do
          title = context_started.title

          comment title.inspect

          test "Not set" do
            assert(title.nil?)
          end
        end
      end

      context "Context Finished Event" do
        context_finished = session.telemetry.one_event(Session::Events::ContextFinished)

        test! "Recorded" do
          refute(context_finished.nil?)
        end

        context "Title Attribute" do
          title = context_finished.title

          comment title.inspect

          test "Not set" do
            assert(title.nil?)
          end
        end
      end
    end
  end
end
