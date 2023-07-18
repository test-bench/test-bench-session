require_relative '../../../automated_init'

context "Substitute Sink" do
  context "Receive Events" do
    context "Non-Session Event" do
      substitute_sink = Session::Substitute::Sink.new

      event_data = Controls::Event.event_data
      substitute_sink.receive(event_data)

      context "Sink's Records" do
        records = substitute_sink.records

        context! "Count" do
          count = records.count

          comment count.inspect

          test "One record" do
            assert(count == 1)
          end
        end
      end
    end
  end
end
