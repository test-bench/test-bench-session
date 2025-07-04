require_relative '../../../automated_init'

context "Substitute Sink" do
  context "Received Predicate" do
    substitute = Substitute::Sink.new

    event_data = Controls::Telemetry::EventData.example
    substitute.receive(event_data)

    context "Received" do
      received = substitute.received?(event_data)

      comment received.inspect

      test do
        assert(received)
      end
    end

    context "Not Received" do
      other_event_data = Controls::Telemetry::EventData.random
      received = substitute.received?(other_event_data)

      comment received.inspect

      test do
        refute(received)
      end
    end
  end
end
