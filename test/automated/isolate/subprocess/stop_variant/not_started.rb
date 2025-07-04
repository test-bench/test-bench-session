require_relative '../../../automated_init'

context "Isolate" do
  context "Subprocess" do
    context "Stop Variant" do
      context "Not Started" do
        isolate = Isolate.new

        assert(isolate.subprocess_id.nil?)

        status = isolate.status
        detail "Status: #{status.inspect}"

        isolate.stop!

        context "Status" do
          status = isolate.status
          control_status = Isolate::Status.stopped

          comment status.inspect
          detail "Control: #{control_status.inspect}"

          test do
            assert(status == control_status)
          end
        end
      end
    end
  end
end
