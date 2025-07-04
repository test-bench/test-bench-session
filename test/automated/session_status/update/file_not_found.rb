require_relative '../../automated_init'

context "Session Status" do
  context "Update" do
    context "File Not Found" do
      file_not_found = Controls::Events::FileNotFound.example

      status = Status.new

      original_error_sequence = Controls::Sequence.example
      status.error_sequence = original_error_sequence

      status.update(file_not_found)

      context "Error Sequence" do
        error_sequence = status.error_sequence
        control_error_sequence = original_error_sequence + 1

        comment "Before: #{original_error_sequence.inspect}"
        comment "After: #{error_sequence.inspect}"
        detail "Control: #{control_error_sequence.inspect}"

        test "Incremented" do
          assert(error_sequence == control_error_sequence)
        end
      end
    end
  end
end
