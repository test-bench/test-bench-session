require_relative '../../automated_init'

context "Session" do
  context "Result" do
    context "Optional Previous Status" do
      previous_status = Controls::Status::Relative.reference

      session = Session.new

      status = Controls::Status::Relative.example
      session.status = status

      result = session.result(previous_status)

      control_result = Controls::Status::Relative.result

      detail result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end
  end
end
