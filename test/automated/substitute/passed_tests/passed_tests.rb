require_relative '../../automated_init'

context "Substitute" do
  context "Passed Tests" do
    passed_test_finished = Controls::Events::TestFinished::Passed.example

    substitute = Substitute.build

    substitute.record_event(passed_test_finished)
    substitute.record_event(Controls::Events::TestFinished::Failed.example)

    context "Match" do
      attributes = passed_test_finished.to_h
      records = substitute.passed_tests(**attributes)

      matches = records.count
      comment "Matches: #{matches}"

      test do
        assert(matches == 1)
      end
    end

    context "No Match" do
      title = Controls::Title.random

      records = substitute.passed_tests(title)

      matches = records.count
      comment "Matches: #{matches}"

      test do
        assert(matches.zero?)
      end
    end
  end
end
