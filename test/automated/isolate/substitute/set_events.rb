require_relative '../../automated_init'

context "Isolate Substitute" do
  context "Set Events" do
    substitute = Isolate::Substitute.build

    event = Controls::Telemetry::EventData.example
    other_event = Controls::Telemetry::EventData.random

    substitute.set_events([event, other_event])

    events = []

    substitute.(Controls::Path::File.example) do |event|
      events << event
    end

    test "Block is supplied the events that were set" do
      assert(events == [event, other_event])
    end
  end
end
