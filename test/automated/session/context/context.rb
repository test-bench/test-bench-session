require_relative '../../automated_init'

context "Session" do
  context "Context" do
    session = Session.new

    control_title = Controls::Title::Context.example

    context_result = session.context(control_title) {}

    context "Result" do
      control_result = Result.none

      comment context_result.inspect
      detail "Control: #{control_result.inspect}"

      context do
        assert(context_result == control_result)
      end
    end

    context "Context Started Event" do
      context_started = session.telemetry.one_event(Events::ContextStarted)

      test! "Recorded" do
        refute(context_started.nil?)
      end

      context "Title Attribute" do
        title = context_started.title

        comment title.inspect
        detail "Control: #{control_title.inspect}"

        test do
          assert(title == control_title)
        end
      end
    end

    context "Context Finished Event" do
      context_finished = session.telemetry.one_event(Events::ContextFinished)

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
          detail "Control: #{context_result.inspect}"

          test do
            assert(result == context_result)
          end
        end
      end
    end
  end
end
