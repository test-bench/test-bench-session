require_relative '../../automated_init'

context "Session" do
  context "Result" do
    session = Session.new

    status = Controls::Status::Passed.example
    session.status = status

    result = session.result

    control_result = Result.passed

    comment result.inspect
    detail "Control: #{control_result.inspect}"

    test do
      assert(result == control_result)
    end
  end
end
