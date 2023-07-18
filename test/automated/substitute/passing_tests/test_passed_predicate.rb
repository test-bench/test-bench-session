require_relative '../../automated_init'

context "Substitute" do
  context "Passing Tests" do
    context "Test Passed Predicate" do
      passing_test_finished = Controls::Events::TestFinished.example(result: true)
      other_passing_test_finished = Controls::Events::TestFinished::Random.example(result: true)
      failing_test_finished = Controls::Events::TestFinished.example(result: false)

      substitute = Session::Substitute.build

      substitute.record_event(passing_test_finished)
      substitute.record_event(other_passing_test_finished)
      substitute.record_event(failing_test_finished)

      context "One Event Matches" do
        attributes = passing_test_finished.to_h

        any_passing_test = substitute.test_passed?(**attributes)

        comment any_passing_test.inspect

        test do
          assert(any_passing_test)
        end
      end

      context "More Than One Event Matches" do
        any_passing_test = substitute.test_passed?

        comment any_passing_test.inspect

        test do
          assert(any_passing_test)
        end
      end

      context "No Event Matches" do
        path_segment = Controls::Random.string

        any_passing_test = substitute.test_passed?(path_segment)

        comment any_passing_test.inspect

        test do
          refute(any_passing_test)
        end
      end
    end
  end
end
