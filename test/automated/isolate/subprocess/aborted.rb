require_relative '../../automated_init'

context "Isolate" do
  context "Subprocess" do
    context "Aborted" do
      apex_directory = Controls::Path::ApexDirectory::Create.()
      comment "Apex directory: #{apex_directory.inspect}"

      isolate = Isolate.new

      isolate.apex_directory = apex_directory

      isolate.start

      subprocess_id = isolate.subprocess_id
      detail "Subprocess ID: #{subprocess_id.inspect}"

      file_path = Controls::Path::File::Create::Exception.(apex_directory:)

      file_path_writer = isolate.file_path_writer

      file_path_writer.puts(file_path)
      comment "Wrote file path: #{file_path.inspect}"

      file_path_writer.close
      comment "Closed file path writer to stop subprocess"

      read_events = []

      context "Read Telemetry" do
        telemetry_reader = isolate.telemetry_reader

        while event_text = telemetry_reader.gets
          detail "Read event:", event_text

          event_data = Telemetry::EventData.load(event_text)

          read_events << event_data
        end

        comment "Done reading telemetry (#{read_events.count} events)"
      end

      context "Isolated Event" do
        isolated_event_data = read_events.find do |event_data|
          Isolate::Isolated === event_data
        end

        detail isolated_event_data.inspect

        test! "Written" do
          refute(isolated_event_data.nil?)
        end

        isolated = Telemetry::Event::Import.(isolated_event_data, Isolate::Isolated)

        context "Result Attribute" do
          result = isolated.result
          control_result = Result.aborted

          comment result.inspect
          detail "Control: #{control_result.inspect}"

          test do
            assert(result == control_result)
          end
        end
      end

      context "Stop" do
        exit_status = isolate.stop

        context "Subprocess ID" do
          subprocess_id = isolate.subprocess_id

          test "Cleared" do
            assert(subprocess_id.nil?)
          end
        end

        context "Exit Status" do
          comment exit_status.inspect

          test "Nonzero" do
            refute(exit_status.zero?)
          end
        end
      end

    ensure
      Controls::Path::ApexDirectory::Remove.(apex_directory)
    end
  end
end
