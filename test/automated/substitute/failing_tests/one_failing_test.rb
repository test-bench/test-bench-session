require_relative '../../automated_init'

context "Substitute" do
  context "Failing Tests" do
    context "One Failing Test" do
      failing_test_finished = Controls::Events::TestFinished.example(result: false)
      other_failing_test_finished = Controls::Events::TestFinished::Random.example(result: false)
      passing_test_finished = Controls::Events::TestFinished.example(result: true)

      substitute = Session::Substitute.build

      substitute.record_event(failing_test_finished)
      substitute.record_event(other_failing_test_finished)
      substitute.record_event(passing_test_finished)

      context "One Event Matches" do
        attributes = failing_test_finished.to_h

        one_event = substitute.one_failing_test(**attributes)

        comment one_event.inspect

        test "Matches the event" do
          assert(one_event == failing_test_finished)
        end
      end

      context "More Than One Event Matches" do
        test "Is an error" do
          assert_raises(Telemetry::Substitute::Sink::MatchError) do
            substitute.one_failing_test
          end
        end
      end

      context "No Events Match" do
        path_segment = Controls::Random.string

        one_event = substitute.one_failing_test(path_segment)

        comment one_event.inspect

        test do
          assert(one_event.nil?)
        end
      end
    end
  end
end
