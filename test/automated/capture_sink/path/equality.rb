require_relative '../../automated_init'

context "Capture Sink" do
  context "Path" do
    context "Equality" do
      path = Controls::CaptureSink::Path.example

      context "Same Segments" do
        segments = path.segments.dup
        compare_path = Controls::CaptureSink::Path.example(segments)

        test "Equal" do
          assert(path == compare_path)
        end
      end

      context "Different Segments" do
        segments = [*path.segments, Controls::Random.string]
        compare_path = Controls::CaptureSink::Path.example(segments)

        test "Not equal" do
          refute(path == compare_path)
        end
      end

      context "Different Classes" do
        compare_object = Object.new

        test "Not equal" do
          refute(path == compare_object)
        end
      end
    end
  end
end
