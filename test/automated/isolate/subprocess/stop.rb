require_relative '../../automated_init'

context "Isolate" do
  context "Subprocess" do
    context "Stop" do
      isolate = Isolate.new

      exit_status = isolate.stop

      context "Status" do
        status = isolate.status
        control_status = Isolate::Status.stopped

        comment status.inspect
        detail "Control: #{control_status.inspect}"

        test do
          assert(status == control_status)
        end
      end

      context "Subprocess Exit Status" do
        comment exit_status.inspect

        test "None" do
          assert(exit_status.nil?)
        end
      end
    end
  end
end
