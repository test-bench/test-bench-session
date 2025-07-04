require_relative '../../automated_init'

context "Session" do
  context "Update" do
    context "Status Updated" do
      session = Session.new

      previous_result = session.status.result

      aborted = Controls::Events::Aborted.example
      session.update(aborted)

      result = session.status.result
      control_result = Result.aborted

      comment "Result Before: #{previous_result.inspect}"
      comment "Result After: #{result.inspect}"
      detail "Control Result: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end
  end
end
