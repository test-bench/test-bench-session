require_relative '../../automated_init'

context "Substitute" do
  context "Failed Tests" do
    failed_test_finished = Controls::Events::TestFinished::Failed.example

    substitute = Substitute.build

    substitute.record_event(failed_test_finished)
    substitute.record_event(Controls::Events::TestFinished::Passed.example)

    context "Match" do
      attributes = failed_test_finished.to_h
      records = substitute.failed_tests(**attributes)

      matches = records.count
      comment "Matches: #{matches}"

      test do
        assert(matches == 1)
      end
    end

    context "No Match" do
      title = Controls::Title.random

      records = substitute.failed_tests(title)

      matches = records.count
      comment "Matches: #{matches}"

      test do
        assert(matches.zero?)
      end
    end
  end
end
