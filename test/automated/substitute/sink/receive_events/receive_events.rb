require_relative '../../../automated_init'

context "Substitute Sink" do
  context "Receive Events" do
    Controls::Events.each_example do |control_event|
      control_event_data = Telemetry::Event::Export.(control_event)

      context "#{control_event.event_type}" do
        substitute_sink = Session::Substitute::Sink.new

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
              assert(record.is_a?(Session::Substitute::Sink::Record))
            end

            context "Event Data" do
              event_data = record.event_data

              comment event_data.inspect
              detail "Control: #{control_event_data.inspect}"

              test do
                assert(event_data == control_event_data)
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
