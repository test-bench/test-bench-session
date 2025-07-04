require_relative '../../automated_init'

context "Substitute Sink" do
  context "One Event Predicate" do
    substitute_sink = Substitute::Sink.new

    event_1 = Controls::Event.example
    event_2 = Controls::Event.random

    control_title = Controls::Title.example

    substitute_sink.trace.push(control_title)

    [event_1, event_2].each do |event|
      event_data = Telemetry::Event::Export.(event)
      substitute_sink.receive(event_data)
    end

    context "One Event Matches" do
      attributes = event_1.to_h

      one_event = substitute_sink.one_event?(Controls::Event::SomeEvent, control_title, **attributes)

      comment one_event.inspect

      test do
        assert(one_event)
      end
    end

    context "Multiple Events Match" do
      test "Is an error" do
        assert_raises(Telemetry::Substitute::Sink::MatchError) do
          substitute_sink.one_event?(Controls::Event::SomeEvent, control_title)
        end
      end
    end

    context "No Events Match" do
      other_title = Controls::Title.other_example

      attributes = event_1.to_h

      one_event = substitute_sink.one_event?(Controls::Event::SomeEvent, other_title, **attributes)

      comment one_event.inspect

      test do
        refute(one_event)
      end
    end
  end
end
