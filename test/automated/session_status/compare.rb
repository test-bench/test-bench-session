require_relative '../automated_init'

context "Session Status" do
  context "Compare" do
    control_status = Controls::Status::Relative.example

    previous_status = Controls::Status::Relative.reference

    status = control_status.compare(previous_status)

    [
      ["Test Sequence", :test_sequence],
      ["Failure Sequence", :failure_sequence],
      ["Error Sequence", :error_sequence],
      ["Skip Sequence", :skip_sequence]
    ].each do |context_title, attribute, sequence_difference|
      context "Test Sequence" do
        sequence = status.public_send(attribute)

        previous_sequence = previous_status.public_send(attribute)
        detail "Previous: #{previous_sequence.inspect}"

        control_sequence = control_status.public_send(attribute)
        detail "Control: #{control_sequence.inspect}"

        comment "Result: #{sequence.inspect}"

        sequence_difference = control_sequence - previous_sequence

        test "Subtracted" do
          assert(sequence == sequence_difference)
        end
      end
    end
  end
end
