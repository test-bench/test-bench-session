require_relative '../../automated_init'

context "Capture Sink" do
  context "Path" do
    context "Pop Segment" do
      context "Path Has Segments" do
        segment = Controls::CaptureSink::Path::Segment.example
        path = Controls::CaptureSink::Path.example([segment])

        path.pop
        comment "Segment Popped"

        context "Path Segments" do
          segments = path.segments

          comment segments.inspect

          test do
            assert(segments == [])
          end
        end
      end

      context "Path Has No Segments" do
        empty_segments = []

        path = Controls::CaptureSink::Path.example(empty_segments)

        path.pop

        test "Nothing popped" do
          assert(path.segments == empty_segments)
        end
      end
    end
  end
end
