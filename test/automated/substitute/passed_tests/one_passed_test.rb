require_relative '../../automated_init'

context "Substitute" do
  context "Passed Tests" do
    context "One Passed Test" do
      passed_test_finished = Controls::Events::TestFinished::Passed.example

      other_passed_test_finished = Controls::Events::TestFinished.example(
        result: Result.passed,
        title: Controls::Title::Test.other_example
      )

      substitute = Substitute.build

      substitute.record_event(passed_test_finished)
      substitute.record_event(other_passed_test_finished)

      context "One Event Matches" do
        attributes = passed_test_finished.to_h

        one_event = substitute.one_passed_test(**attributes)

        comment one_event.inspect

        test "Matches the event" do
          assert(one_event == passed_test_finished)
        end
      end

      context "More Than One Event Matches" do
        test "Is an error" do
          assert_raises(Telemetry::Substitute::Sink::MatchError) do
            substitute.one_passed_test
          end
        end
      end

      context "No Events Match" do
        title = Controls::Title.random

        one_event = substitute.one_passed_test(title)

        comment one_event.inspect

        test do
          assert(one_event.nil?)
        end
      end
    end
  end
end
