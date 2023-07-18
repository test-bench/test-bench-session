require_relative '../../../automated_init'

context "Session" do
  context "Context Variant" do
    context "Context Started Event" do
      session = Session.new

      control_title = Controls::Title::Context.example

      begin
        session.context!(control_title) do
          #
        end
      rescue Session::Abort
      end

      context "Context Started Event" do
        context_started = session.telemetry.one_event(Session::Events::ContextStarted)

        test! "Recorded" do
          refute(context_started.nil?)
        end

        context "Attributes" do
          context "Title" do
            title = context_started.title

            comment title.inspect
            detail "Control: #{control_title.inspect}"

            test do
              assert(title == control_title)
            end
          end
        end
      end
    end
  end
end
