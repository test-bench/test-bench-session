require_relative '../../automated_init'

context "Capture Sink" do
  context "Record" do
    context "Path Segments Match Predicate" do
      path_segments = ['segment-1', 'segment-2', 'segment-3']
      path = Controls::CaptureSink::Path.example(path_segments)

      record = Controls::CaptureSink::Record.example(path:)

      context "Given Segments Match" do
        matches = record.path_segments_match?('segment-1', 'segment-3')

        test "Matches" do
          assert(matches)
        end
      end

      context "Given Segments Don't Match" do
        other_segment = Controls::Random.string

        matches = record.path_segments_match?(other_segment)

        test "Doesn't match" do
          refute(matches)
        end
      end

      context "No Segments" do
        matches = record.path_segments_match?

        test "Matches" do
          assert(matches)
        end
      end
    end
  end
end
