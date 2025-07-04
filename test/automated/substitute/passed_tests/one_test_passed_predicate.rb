require_relative '../../automated_init'

context "Substitute" do
  context "Passed Tests" do
    context "One Test Passed Predicate" do
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

        one_event = substitute.one_test_passed?(**attributes)

        test do
          assert(one_event)
        end
      end

      context "More Than One Event Matches" do
        test "Is an error" do
          assert_raises(Telemetry::Substitute::Sink::MatchError) do
            substitute.one_test_passed?
          end
        end
      end

      context "No Events Match" do
        title = Controls::Title.random

        one_event = substitute.one_test_passed?(title)

        test do
          refute(one_event)
        end
      end
    end
  end
end
