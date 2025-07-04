require_relative '../automated_init'

context "Isolate" do
  apex_directory = Controls::Path::ApexDirectory::Create.()
  comment "Apex directory: #{apex_directory.inspect}"

  isolate = Isolate.new

  isolate.apex_directory = apex_directory

  isolate.start

  original_subprocess_id = isolate.subprocess_id
  detail "Original Subprocess ID: #{original_subprocess_id.inspect}"

  file_path = Controls::Path::File::Create::Comment.(apex_directory:)
  comment "File path: #{file_path.inspect}"

  events = []

  isolate.(file_path) do |event_data|
    commented = Telemetry::Event::Import.(event_data, Events::Commented)
    events << commented
  end

  context "Commented Event" do
    commented = events.first

    recorded = !commented.nil?

    test "Recorded" do
      assert(recorded)
    end
  end

  context "Subprocess" do
    subprocess_id = isolate.subprocess_id

    comment "ID: #{subprocess_id.inspect}"
    detail "Original: #{original_subprocess_id.inspect}"

    not_restarted = subprocess_id == original_subprocess_id

    test "Not restarted" do
      assert(not_restarted)
    end
  end

  exit_status = isolate.stop
  comment "Stopped isolate (Exit Status: #{exit_status.inspect})"

ensure
  Controls::Path::ApexDirectory::Remove.(apex_directory)
end
