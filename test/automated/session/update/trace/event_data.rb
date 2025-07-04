require_relative '../../../automated_init'

context "Session" do
  context "Update" do
    context "Trace" do
      context "Event Data" do
        session = Session.new

        set_trace = Controls::TelemetrySink::SetTrace.register(session)

        context_title = Controls::Title::Context.example
        test_title = Controls::Title::Test.example
        comment_text = Controls::Text::Comment.example
        detail_text = Controls::Text::Detail.example

        context "Context Started" do
          context_started = Controls::Events::ContextStarted.example(title: context_title)
          context_started_data = Telemetry::Event::Export.(context_started)
          session.update(context_started_data)

          trace_text = set_trace.trace_text

          control_text = [
            context_title
          ].join(Trace.join_delimiter)

          comment trace_text.inspect
          detail "Control: #{control_text.inspect}"

          test do
            assert(trace_text == control_text)
          end
        end

        context "Test Started" do
          test_started = Controls::Events::TestStarted.example(title: test_title)
          test_started_data = Telemetry::Event::Export.(test_started)
          session.update(test_started_data)

          trace_text = set_trace.trace_text

          control_text = [
            context_title,
            test_title
          ].join(Trace.join_delimiter)

          comment trace_text.inspect
          detail "Control: #{control_text.inspect}"

          test do
            assert(trace_text == control_text)
          end
        end

        context "Commented" do
          commented = Controls::Events::Commented.example(text: comment_text)
          commented_data = Telemetry::Event::Export.(commented)
          session.update(commented_data)

          trace_text = set_trace.trace_text

          control_text = [
            context_title,
            test_title,
            comment_text
          ].join(Trace.join_delimiter)

          comment trace_text.inspect
          detail "Control: #{control_text.inspect}"

          test do
            assert(trace_text == control_text)
          end
        end

        context "Detailed" do
          detailed = Controls::Events::Commented.example(text: detail_text)
          detailed_data = Telemetry::Event::Export.(detailed)
          session.update(detailed_data)

          trace_text = set_trace.trace_text

          control_text = [
            context_title,
            test_title,
            detail_text
          ].join(Trace.join_delimiter)

          comment trace_text.inspect
          detail "Control: #{control_text.inspect}"

          test do
            assert(trace_text == control_text)
          end
        end

        context "Test Finished" do
          test_finished = Controls::Events::TestFinished.example(title: test_title)
          test_finished_data = Telemetry::Event::Export.(test_finished)
          session.update(test_finished_data)

          trace_text = set_trace.trace_text

          control_text = [
            context_title,
            test_title
          ].join(Trace.join_delimiter)

          comment trace_text.inspect
          detail "Control: #{control_text.inspect}"

          test do
            assert(trace_text == control_text)
          end
        end

        context "Context Finished" do
          context_finished = Controls::Events::TestFinished.example(title: context_title)
          context_finished_data = Telemetry::Event::Export.(context_finished)
          session.update(context_finished_data)

          trace_text = set_trace.trace_text

          control_text = [
            context_title
          ].join(Trace.join_delimiter)

          comment trace_text.inspect
          detail "Control: #{control_text.inspect}"

          test do
            assert(trace_text == control_text)
          end
        end
      end
    end
  end
end
