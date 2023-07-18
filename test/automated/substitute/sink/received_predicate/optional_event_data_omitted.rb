require_relative '../../../automated_init'

context "Substitute Sink" do
  context "Received Predicate" do
    context "Optional Event Data Omitted" do
      context "Received" do
        substitute = Session::Substitute::Sink.new

        event_data = Controls::Event.event_data
        substitute.receive(event_data)

        received = substitute.received?

        comment received.inspect

        test do
          assert(received)
        end
      end

      context "Not Received" do
        substitute = Session::Substitute::Sink.new

        received = substitute.received?

        comment received.inspect

        test do
          refute(received)
        end
      end
    end
  end
end
