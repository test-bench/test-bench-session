require_relative '../../automated_init'

context "Capture Sink" do
  context "Handle Events" do
    Controls::Events.each_example do |control_event|
      event_type = control_event.event_type

      context "#{event_type}" do
        telemetry_sink = Session::Telemetry::CaptureSink.new

        telemetry_sink.(control_event)

        context "Sink's Records" do
          records = telemetry_sink.records

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
              assert(record.is_a?(Session::Telemetry::CaptureSink::Record))
            end

            context "Event" do
              event = record.event

              comment event.inspect
              detail "Control: #{control_event.inspect}"

              test do
                assert(event == control_event)
              end
            end

            context "Path" do
              path = record.path

              test "Set" do
                refute(path.nil?)
              end
            end
          end
        end
      end
    end
  end
end
