require_relative '../../../automated_init'

context "Session" do
  context "Update" do
    context "Trace" do
      context "No Title" do
        session = Session.new

        set_trace = Controls::TelemetrySink::SetTrace.register(session)

        control_title = Controls::Title.example
        session.trace.push(control_title)

        [
          ["Context Started", Controls::Events::ContextStarted::NoTitle.example],
          ["Test Started", Controls::Events::TestStarted::NoTitle.example],
          ["Test Finished", Controls::Events::TestFinished::NoTitle.example],
          ["Context Finished", Controls::Events::ContextFinished::NoTitle.example]
        ].each do |context_title, event|
          context "#{context_title}" do
            session.update(event)

            trace_text = set_trace.trace_text

            comment trace_text.inspect
            detail "Control: #{control_title.inspect}"

            test do
              assert(trace_text == control_title)
            end
          end
        end
      end
    end
  end
end
