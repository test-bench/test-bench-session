require_relative '../../automated_init'

context "Substitute Sink" do
  context "Events" do
    substitute_sink = Session::Substitute::Sink.new

    event_1 = Controls::Event.example
    event_2 = Controls::Event.other_example
    event_3 = Controls::Event.random

    path_segments = ['some-segment']
    substitute_sink.path = Controls::Substitute::Path.example(path_segments)
    [event_1, event_2].each do |event|
      event_data = Telemetry::Event::Export.(event)
      substitute_sink.receive(event_data)
    end

    path_segments = ['some-other-segment']
    substitute_sink.path = Controls::Substitute::Path.example(path_segments)
    [event_3].each do |event|
      event_data = Telemetry::Event::Export.(event)
      substitute_sink.receive(event_data)
    end

    context "Multiple Events Match" do
      events = substitute_sink.events(Controls::Event::SomeEvent)

      control_events = [event_1, event_3]

      comment events.count.to_s
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end

    context "One Event Matches" do
      attributes = event_1.to_h

      events = substitute_sink.events(Controls::Event::SomeEvent, **attributes)

      control_events = [event_1]

      comment events.count.to_s
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end

    context "No Events Match" do
      events = substitute_sink.events(Controls::Event::SomeEvent, 'yet-another-segment')

      control_events = []

      comment events.count.to_s
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end
  end
end
