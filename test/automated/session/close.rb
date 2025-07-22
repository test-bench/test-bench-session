require_relative '../automated_init'

context "Session" do
  context "Close" do
    session = Session.new

    isolate = Isolate.configure(session)
    isolate.start

    session.close

    context "Isolate" do
      status = isolate.status

      control_status = Isolate::Status.stopped

      comment status.inspect
      detail "Control: #{control_status.inspect}"

      test "Stopped" do
        assert(status == control_status)
      end
    end
  end
end
