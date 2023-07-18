
require_relative '../../automated_init'

context "Substitute" do
  context "Failing Tests" do
    context "One Test Failed Predicate" do
      failing_test_finished = Controls::Events::TestFinished.example(result: false)
      other_failing_test_finished = Controls::Events::TestFinished::Random.example(result: false)
      passing_test_finished = Controls::Events::TestFinished.example(result: true)

      substitute = Session::Substitute.build

      substitute.record_event(failing_test_finished)
      substitute.record_event(other_failing_test_finished)
      substitute.record_event(passing_test_finished)

      context "One Event Matches" do
        attributes = failing_test_finished.to_h

        one_event = substitute.one_test_failed?(**attributes)

        test do
          assert(one_event)
        end
      end

      context "More Than One Event Matches" do
        test "Is an error" do
          assert_raises(Telemetry::Substitute::Sink::MatchError) do
            substitute.one_test_failed?
          end
        end
      end

      context "No Events Match" do
        path_segment = Controls::Random.string

        one_event = substitute.one_test_failed?(path_segment)

        test do
          refute(one_event)
        end
      end
    end
  end
end
