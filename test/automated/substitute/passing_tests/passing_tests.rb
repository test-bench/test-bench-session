require_relative '../../automated_init'

context "Substitute" do
  context "Passing Tests" do
    passing_test_finished = Controls::Events::TestFinished.example(result: true)
    failing_test_finished = Controls::Events::TestFinished.example(result: false)

    substitute = Session::Substitute.build

    substitute.record_event(passing_test_finished)
    substitute.record_event(failing_test_finished)

    context "Match" do
      attributes = passing_test_finished.to_h
      records = substitute.passing_tests(**attributes)

      matches = records.count
      comment "Matches: #{matches}"

      test do
        assert(matches == 1)
      end
    end

    context "No Match" do
      path_segment = Controls::Random.string

      records = substitute.passing_tests(path_segment)

      matches = records.count
      comment "Matches: #{matches}"

      test do
        assert(matches.zero?)
      end
    end
  end
end
