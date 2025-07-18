require_relative '../automated_init'

context "Isolate" do
  context "Nested Isolation" do
    apex_directory = Controls::Path::ApexDirectory::Create.()
    comment "Apex directory: #{apex_directory.inspect}"

    isolate = Isolate.new

    isolate.apex_directory = apex_directory

    isolate.start

    original_subprocess_id = isolate.subprocess_id
    detail "Original Subprocess ID: #{original_subprocess_id.inspect}"

    other_file_path = Controls::Path::File.example

    file_path = Controls::Path::File::Create.(<<~RUBY, apex_directory:)
    commented = #{Controls::Events::Commented}.example
    #{Session}.instance.record_event(commented)

    isolated = #{Isolate::Isolated}.build(#{other_file_path.inspect}, #{Result}.passed)
    #{Session}.instance.record_event(isolated)
    RUBY
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

    exit_status = isolate.stop
    comment "Stopped isolate (Exit Status: #{exit_status.inspect})"

  ensure
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
end
