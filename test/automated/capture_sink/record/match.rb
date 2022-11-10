require_relative '../../automated_init'

context "Capture Sink" do
  context "Record" do
    context "Match Predicate" do
      event = Controls::CaptureSink::Event.example

      control_segments = ['segment-1', 'segment-2', 'segment-3']
      path = Controls::CaptureSink::Path.example(control_segments)

      record = Controls::CaptureSink::Record.example(event:, path:)

      context "Matches" do
        matches = record.match?(*control_segments) do |event_type, *values|
          event_type == event.event_type && values == event.values
        end

        test do
          assert(matches)
        end
      end

      context "Doesn't Match" do
        context "Path Segments Don't Match" do
          other_segment = Controls::Random.string

          matches = record.match?(other_segment) do |event_type, *values|
            event_type == event.event_type && values == event.values
          end

          test do
            refute(matches)
          end
        end

        context "Block Doesn't Match" do
          matches = record.match?(*control_segments) { false }

          test do
            refute(matches)
          end
        end
      end
    end
  end
end
