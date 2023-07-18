require_relative '../../automated_init'

context "Substitute" do
  context "Path" do
    context "Pop Segment" do
      context "Path Has Segments" do
        segment = Controls::Substitute::Path::Segment.example
        path = Controls::Substitute::Path.example([segment])

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

        path = Controls::Substitute::Path.example(empty_segments)

        path.pop

        test "Nothing popped" do
          assert(path.segments == empty_segments)
        end
      end
    end
  end
end
