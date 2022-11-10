require_relative '../../automated_init'

context "Capture Sink" do
  context "Path" do
    context "Push Segments" do
      path = Session::Telemetry::CaptureSink::Path.new

      control_segments = Controls::CaptureSink::Path::Segment.examples

      control_segments.each do |segment|
        path.push(segment)

        comment "Pushed #{segment.inspect}"
      end

      context "Path Segments" do
        segments = path.segments

        comment segments.inspect

        test do
          assert(segments == control_segments)
        end
      end
    end
  end
end
