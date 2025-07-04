require_relative '../../automated_init'

context "Substitute Sink" do
  context "Any Event Predicate" do
    substitute_sink = Substitute::Sink.new

    event_1 = Controls::Event.example
    event_2 = Controls::Event.random

    control_title = Controls::Title.example

    substitute_sink.trace.push(control_title)

    [event_1, event_2].each do |event|
      event_data = Telemetry::Event::Export.(event)
      substitute_sink.receive(event_data)
    end

    context "Multiple Events Match" do
      any_event = substitute_sink.event?(Controls::Event::SomeEvent, control_title)

      comment any_event.inspect

      test do
        assert(any_event)
      end
    end

    context "One Event Matches" do
      attributes = event_1.to_h

      any_event = substitute_sink.event?(Controls::Event::SomeEvent, control_title, **attributes)

      comment any_event.inspect

      test do
        assert(any_event)
      end
    end

    context "No Events Match" do
      other_title = Controls::Title.other_example

      attributes = event_1.to_h

      any_event = substitute_sink.event?(Controls::Event::SomeEvent, other_title, **attributes)

      comment any_event.inspect

      test do
        refute(any_event)
      end
    end
  end
end
