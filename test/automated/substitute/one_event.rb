require_relative '../automated_init'

context "Substitute" do
  context "One Event Methods" do
    events = Controls::Events.examples
    other_events = Controls::Events.examples(random: true)

    events.zip(other_events).each do |(event, other_event)|
      event_type = event.event_type

      event_type_method_cased = Telemetry::Event::Type.method_cased(event_type)

      one_event_method = :"one_#{event_type_method_cased}_event"

      context "#{one_event_method}" do
        substitute = Session::Substitute.build

        substitute.telemetry.record(event)
        substitute.telemetry.record(other_event)

        context "One Event Matches" do
          attributes = event.to_h

          one_event = substitute.public_send(one_event_method, **attributes)

          test "Matches the event" do
            assert(one_event == event)
          end
        end

        context "More Than One Event Matches" do
          test "Is an error" do
            assert_raises(Telemetry::Substitute::Telemetry::MatchError) do
              substitute.public_send(one_event_method)
            end
          end
        end

        context "No Events Match" do
          attributes = {
            event.members.first => Controls::Random.string
          }

          one_event = substitute.public_send(one_event_method, **attributes)

          comment one_event.inspect

          test do
            assert(one_event.nil?)
          end
        end
      end
    end
  end
end
