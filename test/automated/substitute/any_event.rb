require_relative '../automated_init'

context "Substitute" do
  context "Any Event Predicate Methods" do
    events = Controls::Events.examples
    other_events = Controls::Events.examples(random: true)

    events.zip(other_events).each do |(event, other_event)|
      event_type = event.event_type

      event_type_method_cased = Telemetry::Event::Type.method_cased(event_type)

      any_event_method = :"#{event_type_method_cased}_event?"

      context "#{any_event_method}" do
        substitute = Session::Substitute.build

        substitute.telemetry.record(event)
        substitute.telemetry.record(other_event)

        context "One Event Matches" do
          attributes = event.to_h

          any_event = substitute.public_send(any_event_method, **attributes)

          comment any_event.inspect

          test do
            assert(any_event)
          end
        end

        context "More Than One Event Matches" do
          any_event = substitute.public_send(any_event_method)

          comment any_event.inspect

          test do
            assert(any_event)
          end
        end

        context "No Events Match" do
          attributes = {
            event.members.first => Controls::Random.string
          }

          any_event = substitute.public_send(any_event_method, **attributes)

          comment any_event.inspect

          test do
            refute(any_event)
          end
        end
      end
    end
  end
end
