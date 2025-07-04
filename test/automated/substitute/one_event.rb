require_relative '../automated_init'

context "Substitute" do
  context "One Event Methods" do
    events = Controls::Events.examples
    other_events = Controls::Events.other_examples

    events.zip(other_events).each do |(event, other_event)|
      event_type = event.event_type

      event_name = Telemetry::Event::EventName.get(event_type)

      one_event_method = :"one_#{event_name}_event"

      context "#{one_event_method}" do
        substitute = Substitute.build

        substitute.record_event(event)
        substitute.record_event(other_event)

        context "One Event Matches" do
          attributes = event.to_h

          one_event = substitute.public_send(one_event_method, **attributes)

          test "Matches the event" do
            assert(one_event == event)
          end
        end

        context "More Than One Event Matches" do
          test "Is an error" do
            assert_raises(Telemetry::Substitute::Sink::MatchError) do
              substitute.public_send(one_event_method)
            end
          end
        end

        context "No Events Match" do
          title = Controls::Title.random

          one_event = substitute.public_send(one_event_method, title)

          comment one_event.inspect

          test do
            assert(one_event.nil?)
          end
        end
      end
    end
  end
end
