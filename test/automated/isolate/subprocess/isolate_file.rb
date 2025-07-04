require_relative '../../automated_init'

context "Isolate" do
  context "Subprocess" do
    context "Isolate File" do
      apex_directory = Controls::Path::ApexDirectory::Create.()
      comment "Apex directory: #{apex_directory.inspect}"

      isolate = Isolate.new

      isolate.apex_directory = apex_directory

      isolate.start

      subprocess_id = isolate.subprocess_id
      detail "Subprocess ID: #{subprocess_id.inspect}"

      file_path = Controls::Path::File::Create.(apex_directory:)

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

        test "Final event" do
          assert(isolated_event_data == read_events.last)
        end

        isolated = Telemetry::Event::Import.(isolated_event_data, Isolate::Isolated)

        context "Attributes" do
          context "File" do
            file = isolated.file
            control_file = file_path

            comment file.inspect
            detail "Control: #{control_file.inspect}"

            test do
              assert(file == control_file)
            end
          end

          context "Result" do
            result = isolated.result

            comment result.inspect

            test do
              refute(result.nil?)
            end
          end
        end
      end

      exit_status = isolate.stop
      comment "Stopped isolate (Exit Status: #{exit_status.inspect})"

    ensure
      Controls::Path::ApexDirectory::Remove.(apex_directory)
    end
  end
end
