require_relative '../../automated_init'

context "Session Status" do
  context "Result" do
    context "Optional Previous Status" do
      previous_status = Controls::Status::Relative.reference

      status = Controls::Status::Relative.example

      result = status.result(previous_status)

      control_result = Controls::Status::Relative.result

      comment result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end
  end
end
