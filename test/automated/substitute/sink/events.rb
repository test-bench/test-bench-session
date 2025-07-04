require_relative '../../automated_init'

context "Substitute Sink" do
  context "Events" do
    substitute_sink = Substitute::Sink.new

    event_1 = Controls::Event.example
    event_2 = Controls::Event.random
    event_3 = Controls::Event.other_example

    control_title = Controls::Title.example

    substitute_sink.trace.push(control_title)

    [event_1, event_2, event_3].each do |event|
      event_data = Telemetry::Event::Export.(event)
      substitute_sink.receive(event_data)
    end

    context "Multiple Events Match" do
      events = substitute_sink.events(Controls::Event::SomeEvent, control_title)

      control_events = [event_1, event_2]

      comment events.count.to_s
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end

    context "One Event Matches" do
      attributes = event_1.to_h

      events = substitute_sink.events(Controls::Event::SomeEvent, control_title, **attributes)

      control_events = [event_1]

      comment events.count.to_s
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end

    context "No Events Match" do
      other_title = Controls::Title.other_example

      attributes = event_1.to_h

      events = substitute_sink.events(Controls::Event::SomeEvent, other_title, **attributes)

      control_events = []

      comment events.count.to_s
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end
  end
end
