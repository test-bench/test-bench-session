require_relative '../../automated_init'

context "Session Status" do
  context "Update" do
    event = Controls::Event.example

    status = Status.initial

    status.update(event)

    context "Test Sequence" do
      test_sequence = status.test_sequence

      detail test_sequence.inspect

      test "Not changed" do
        assert(test_sequence.zero?)
      end
    end

    context "Failure Sequence" do
      failure_sequence = status.failure_sequence

      detail failure_sequence.inspect

      test "Not changed" do
        assert(failure_sequence.zero?)
      end
    end

    context "Error Sequence" do
      error_sequence = status.error_sequence

      detail error_sequence.inspect

      test "Not changed" do
        assert(error_sequence.zero?)
      end
    end

    context "Skip Sequence" do
      skip_sequence = status.skip_sequence

      detail skip_sequence.inspect

      test "Not changed" do
        assert(skip_sequence.zero?)
      end
    end
  end
end
