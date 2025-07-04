require_relative '../../automated_init'

context "Substitute" do
  context "Passed Tests" do
    context "Test Passed Predicate" do
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

        any_passed_test = substitute.test_passed?(**attributes)

        comment any_passed_test.inspect

        test do
          assert(any_passed_test)
        end
      end

      context "More Than One Event Matches" do
        any_passed_test = substitute.test_passed?

        comment any_passed_test.inspect

        test do
          assert(any_passed_test)
        end
      end

      context "No Event Matches" do
        title = Controls::Title.random

        any_passed_test = substitute.test_passed?(title)

        comment any_passed_test.inspect

        test do
          refute(any_passed_test)
        end
      end
    end
  end
end
