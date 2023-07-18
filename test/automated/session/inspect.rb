require_relative '../automated_init'

context "Session" do
  context "Inspect" do
    session = Session.new

    session.failure_sequence = 1
    session.assertion_sequence = 11
    session.skip_sequence = 111

    commented = Controls::Events::Commented.example
    session.telemetry.record(commented)

    text = session.inspect

    comment text

    context "Failure Sequence" do
      shown = text.include?('@failure_sequence=1')

      test "Shown" do
        assert(shown)
      end
    end

    context "Assertion Sequence" do
      shown = text.include?('@assertion_sequence=11')

      test "Shown" do
        assert(shown)
      end
    end

    context "Skip Sequence" do
      shown = text.include?('@skip_sequence=111')

      test "Shown" do
        assert(shown)
      end
    end

    context "Telemetry Dependency" do
      shown = text.include?('@telemetry')

      test "Not shown" do
        refute(shown)
      end
    end
  end
end
