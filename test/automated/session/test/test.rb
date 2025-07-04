require_relative '../../automated_init'

context "Session" do
  context "Test" do
    session = Session.new

    control_title = Controls::Title::Test.example

    assertion_sequence = Controls::Sequence.example
    session.assertion_sequence = assertion_sequence

    test_result = session.test(control_title) do
      session.assertion_sequence = assertion_sequence + 1
    end

    context "Result" do
      control_result = Result.passed

      comment test_result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(test_result == control_result)
      end
    end

    context "Test Started Event" do
      test_started = session.telemetry.one_event(Events::TestStarted)

      test! "Recorded" do
        refute(test_started.nil?)
      end

      context "Title Attribute" do
        title = test_started.title

        comment title.inspect
        detail "Control: #{control_title.inspect}"

        test do
          assert(title == control_title)
        end
      end
    end

    context "Test Finished Event" do
      test_finished = session.telemetry.one_event(Events::TestFinished)

      test! "Recorded" do
        refute(test_finished.nil?)
      end

      context "Attributes" do
        context "Title" do
          title = test_finished.title

          comment title.inspect
          detail "Control: #{control_title.inspect}"

          test do
            assert(title == control_title)
          end
        end

        context "Result" do
          result = test_finished.result

          comment result.inspect
          detail "Control: #{test_result.inspect}"

          test do
            assert(result == test_result)
          end
        end
      end
    end
  end
end
