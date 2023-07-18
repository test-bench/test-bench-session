require_relative '../../automated_init'

context "Substitute Sink" do
  context "Any Event Predicate" do
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
      any_event = substitute_sink.event?(Controls::Event::SomeEvent)

      comment any_event.inspect

      test do
        assert(any_event)
      end
    end

    context "One Event Matches" do
      attributes = event_1.to_h

      any_event = substitute_sink.event?(Controls::Event::SomeEvent, **attributes)

      comment any_event.inspect

      test do
        assert(any_event)
      end
    end

    context "No Events Match" do
      any_event = substitute_sink.event?(Controls::Event::SomeEvent, 'yet-another-segment')

      comment any_event.inspect

      test do
        refute(any_event)
      end
    end
  end
end
