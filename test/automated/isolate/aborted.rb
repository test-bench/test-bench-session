require_relative '../automated_init'

context "Isolate" do
  context "Aborted" do
    apex_directory = Controls::Path::ApexDirectory::Create.()
    comment "Apex directory: #{apex_directory.inspect}"

    isolate = Isolate.new

    isolate.apex_directory = apex_directory

    isolate.start

    original_subprocess_id = isolate.subprocess_id
    comment "Original Subprocess ID: #{original_subprocess_id.inspect}"

    file_path = Controls::Path::File::Create::Exception.(apex_directory:)
    comment "File path: #{file_path.inspect}"

    isolate.(file_path) {}

    context "Status" do
      status = isolate.status
      control_status = Isolate::Status.stopping

      comment status.inspect
      detail "Control: #{control_status.inspect}"

      test "Stopping" do
        assert(status == control_status)
      end
    end

    exit_status = isolate.stop
    comment "Stopped isolate (Exit Status: #{exit_status.inspect})"

  ensure
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
end
