require_relative '../../automated_init'

context "Substitute Sink" do
  context "One Event Predicate" do
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

    context "One Event Matches" do
      attributes = event_1.to_h

      one_event = substitute_sink.one_event?(Controls::Event::SomeEvent, **attributes)

      comment one_event.inspect

      test do
        assert(one_event)
      end
    end

    context "Multiple Events Match" do
      test "Is an error" do
        assert_raises(Telemetry::Substitute::Sink::MatchError) do
          substitute_sink.one_event?(Controls::Event::SomeEvent)
        end
      end
    end

    context "No Events Match" do
      one_event = substitute_sink.one_event?(Controls::Event::SomeEvent, 'yet-another-segment')

      comment one_event.inspect

      test do
        refute(one_event)
      end
    end
  end
end
