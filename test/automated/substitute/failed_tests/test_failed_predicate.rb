require_relative '../../automated_init'

context "Substitute" do
  context "Failed Tests" do
    context "Test Failed Predicate" do
      failed_test_finished = Controls::Events::TestFinished::Failed.example

      other_failed_test_finished = Controls::Events::TestFinished.example(
        result: Result.failed,
        title: Controls::Title::Test.other_example
      )

      substitute = Substitute.build

      substitute.record_event(failed_test_finished)
      substitute.record_event(other_failed_test_finished)

      context "One Event Matches" do
        attributes = failed_test_finished.to_h

        any_failed_test = substitute.test_failed?(**attributes)

        comment any_failed_test.inspect

        test do
          assert(any_failed_test)
        end
      end

      context "More Than One Event Matches" do
        any_failed_test = substitute.test_failed?

        comment any_failed_test.inspect

        test do
          assert(any_failed_test)
        end
      end

      context "No Event Matches" do
        title = Controls::Title.random

        any_failed_test = substitute.test_failed?(title)

        comment any_failed_test.inspect

        test do
          refute(any_failed_test)
        end
      end
    end
  end
end
