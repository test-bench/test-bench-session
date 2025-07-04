require_relative '../automated_init'

context "Isolate" do
  context "Stopping" do
    apex_directory = Controls::Path::ApexDirectory::Create.()
    comment "Apex directory: #{apex_directory.inspect}"

    isolate = Isolate.new

    isolate.start
    isolate.stop!

    isolate.apex_directory = apex_directory

    file_path = Controls::Path::File::Create.(apex_directory:)
    comment "File path: #{file_path.inspect}"

    isolate.(file_path) {}

    context "Subprocess" do
      subprocess_id = isolate.subprocess_id

      comment subprocess_id.inspect

      started = !subprocess_id.nil?

      test "Started" do
        assert(started)
      end
    end

    exit_status = isolate.stop
    comment "Stopped isolate (Exit Status: #{exit_status.inspect})"

  ensure
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
end
