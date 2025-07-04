require_relative '../../../automated_init'

context "Substitute Sink" do
  context "Receive" do
    substitute_sink = Substitute::Sink.new

    control_event_data = Controls::Telemetry::EventData.example

    substitute_sink.receive(control_event_data)

    context "Sink's Records" do
      records = substitute_sink.records

      context! "Count" do
        count = records.count

        comment count.inspect

        test "One record" do
          assert(count == 1)
        end
      end

      context "Record" do
        record = records.first

        comment record.class.inspect

        test! do
          assert(record.is_a?(Substitute::Sink::Record))
        end

        context "Event Data" do
          event_data = record.event_data

          comment event_data.inspect
          detail "Control: #{control_event_data.inspect}"

          test do
            assert(event_data == control_event_data)
          end
        end
      end
    end
  end
end
