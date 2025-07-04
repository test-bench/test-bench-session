require_relative '../../../automated_init'

context "Session" do
  context "Update" do
    context "Trace" do
      session = Session.new

      set_trace = Controls::TelemetrySink::SetTrace.register(session)

      context_title = Controls::Title::Context.example
      test_title = Controls::Title::Test.example
      comment_text = Controls::Text::Comment.example
      detail_text = Controls::Text::Detail.example

      context "Context Started" do
        context_started = Controls::Events::ContextStarted.example(title: context_title)
        session.update(context_started)

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
        session.update(test_started)

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
        session.update(commented)

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
        detailed = Controls::Events::Detailed.example(text: detail_text)
        session.update(detailed)

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
        session.update(test_finished)

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
        context_finished = Controls::Events::ContextFinished.example(title: context_title)
        session.update(context_finished)

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
