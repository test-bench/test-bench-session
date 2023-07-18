
require_relative '../../automated_init'

context "Substitute" do
  context "Passing Tests" do
    context "One Test Passed Predicate" do
      passing_test_finished = Controls::Events::TestFinished.example(result: true)
      other_passing_test_finished = Controls::Events::TestFinished::Random.example(result: true)
      failing_test_finished = Controls::Events::TestFinished.example(result: false)

      substitute = Session::Substitute.build

      substitute.record_event(passing_test_finished)
      substitute.record_event(other_passing_test_finished)
      substitute.record_event(failing_test_finished)

      context "One Event Matches" do
        attributes = passing_test_finished.to_h

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
        path_segment = Controls::Random.string

        one_event = substitute.one_test_passed?(path_segment)

        test do
          refute(one_event)
        end
      end
    end
  end
end
