require_relative '../../../automated_init'

context "Substitute Sink" do
  context "Receive Event" do
    context "Trace Copied" do
      control_trace = Trace.new
      control_trace.push(Controls::Title.example)

      substitute_sink = Substitute::Sink.build(control_trace)

      record = substitute_sink.receive(Controls::Telemetry::EventData.example)

      trace = record.trace

      copied = trace.to_a == control_trace.to_a &&
        !trace.to_a.equal?(control_trace.to_a)

      test do
        assert(copied)
      end
    end
  end
end
