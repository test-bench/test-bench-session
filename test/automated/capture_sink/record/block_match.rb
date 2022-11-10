require_relative '../../automated_init'

context "Capture Sink" do
  context "Record" do
    context "Block Match Predicate" do
      event = Controls::CaptureSink::Event.example

      record = Controls::CaptureSink::Record.example(event:)

      context "Block Indicates A Match" do
        matches = record.block_match? do |event_type, *values|
          event_type == event.event_type && values == event.values
        end

        test "Matches" do
          assert(matches)
        end
      end

      context "Block Doesn't Indicate A Match" do
        matches = record.block_match? { false }

        test "Doesn't match" do
          refute(matches)
        end
      end

      context "No Block" do
        matches = record.block_match?

        test "Matches" do
          assert(matches)
        end
      end
    end
  end
end
