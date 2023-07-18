require_relative '../automated_init'

context "Substitute" do
  context "Events Methods" do
    events = Controls::Events.examples
    other_events = Controls::Events.examples(random: true)

    events.zip(other_events).each do |(event, other_event)|
      event_type = event.event_type

      event_name = Telemetry::Event::EventName.get(event_type)

      events_method = :"#{event_name}_events"

      context "#{events_method}" do
        substitute = Session::Substitute.build

        substitute.record_event(event)
        substitute.record_event(other_event)

        context "Match" do
          attributes = event.to_h

          records = substitute.public_send(events_method, **attributes)

          matches = records.count
          comment "Matches: #{matches}"

          test do
            assert(matches == 1)
          end
        end

        context "No Match" do
          path_segment = Controls::Random.string

          records = substitute.public_send(events_method, path_segment)

          matches = records.count
          comment "Matches: #{matches}"

          test do
            assert(matches.zero?)
          end
        end
      end
    end
  end
end
