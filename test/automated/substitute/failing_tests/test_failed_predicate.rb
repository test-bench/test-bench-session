require_relative '../../automated_init'

context "Substitute" do
  context "Failing Tests" do
    context "Test Failed Predicate" do
      failing_test_finished = Controls::Events::TestFinished.example(result: false)
      other_failing_test_finished = Controls::Events::TestFinished::Random.example(result: false)
      passing_test_finished = Controls::Events::TestFinished.example(result: true)

      substitute = Session::Substitute.build

      substitute.record_event(failing_test_finished)
      substitute.record_event(other_failing_test_finished)
      substitute.record_event(passing_test_finished)

      context "One Event Matches" do
        attributes = failing_test_finished.to_h

        any_failing_test = substitute.test_failed?(**attributes)

        comment any_failing_test.inspect

        test do
          assert(any_failing_test)
        end
      end

      context "More Than One Event Matches" do
        any_failing_test = substitute.test_failed?

        comment any_failing_test.inspect

        test do
          assert(any_failing_test)
        end
      end

      context "No Event Matches" do
        path_segment = Controls::Random.string

        any_failing_test = substitute.test_failed?(path_segment)

        comment any_failing_test.inspect

        test do
          refute(any_failing_test)
        end
      end
    end
  end
end
