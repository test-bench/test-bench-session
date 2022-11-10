require_relative '../automated_init'

context "Capture Sink" do
  context "Match Events" do
    capture_sink = Session::Telemetry::CaptureSink.new

    path_segments = ['some-segment']
    capture_sink.path = Controls::CaptureSink::Path.example(path_segments)

    event_1 = Controls::CaptureSink::Event.example
    event_2 = Controls::CaptureSink::Event.random
    event_3 = Controls::CaptureSink::Event::OtherExample.new

    capture_sink.(event_1)
    capture_sink.(event_2)
    capture_sink.(event_3)

    context "Multiple Events Match" do
      events = capture_sink.match_events(Controls::CaptureSink::Event::Example, 'some-segment')
      control_events = [event_1, event_2]

      comment events.count
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end

    context "One Event Matches" do
      events = capture_sink.match_events(Controls::CaptureSink::Event::OtherExample, 'some-segment')

      control_events = [event_3]

      comment events.count
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end

    context "No Events Match" do
      events = capture_sink.match_events(Controls::CaptureSink::Event::Example, 'some-other-segment')

      control_events = []

      comment events.count
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end
  end
end
