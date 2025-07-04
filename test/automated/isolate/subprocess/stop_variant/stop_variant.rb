require_relative '../../../automated_init'

context "Isolate" do
  context "Subprocess" do
    context "Stop Variant" do
      isolate = Isolate.new

      isolate.start

      subprocess_id = isolate.subprocess_id
      detail "Subprocess ID: #{subprocess_id.inspect}"

      status = isolate.status
      detail "Status: #{status.inspect}"

      exit_status = isolate.stop!

      context "Status" do
        status = isolate.status
        control_status = Isolate::Status.stopping

        comment status.inspect
        detail "Control: #{control_status.inspect}"

        test do
          assert(status == control_status)
        end
      end

      context "Telemetry Reader" do
        telemetry_reader = isolate.telemetry_reader

        test "Closed" do
          assert(telemetry_reader.closed?)
        end
      end

      context "File Path Writer" do
        file_path_writer = isolate.file_path_writer

        test "Closed" do
          assert(file_path_writer.closed?)
        end
      end

      exit_status = isolate.stop
      comment "Stopped isolate (Exit Status: #{exit_status.inspect})"
    end
  end
end
