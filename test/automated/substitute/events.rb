require_relative '../automated_init'

context "Substitute" do
  context "Events Methods" do
    events = Controls::Events.examples
    other_events = Controls::Events.examples(random: true)

    events.zip(other_events).each do |(event, other_event)|
      event_type = event.event_type

      event_type_method_cased = Telemetry::Event::Type.method_cased(event_type)

      events_method = :"#{event_type_method_cased}_events"

      context "#{events_method}" do
        substitute = Session::Substitute.build

        substitute.telemetry.record(event)
        substitute.telemetry.record(other_event)

        attributes = event.to_h

        records = substitute.public_send(events_method, **attributes)

        matches = records.count
        comment "Matches: #{matches}"

        test do
          assert(matches == 1)
        end
      end
    end
  end
end
