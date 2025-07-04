require_relative '../../automated_init'

context "Session" do
  context "Execute File" do
    context "File Not Found" do
      file_path = Controls::Path::File.example

      session = Session.new

      session.execute(file_path)

      context "File Not Found Event" do
        file_not_found = session.telemetry.one_event(Events::FileNotFound)

        test! "Recorded" do
          refute(file_not_found.nil?)
        end

        context "File Attribute" do
          file = file_not_found.file
          control_file = file_path

          comment file.inspect
          detail "Control: #{control_file.inspect}"

          test do
            assert(file == control_file)
          end
        end
      end

      context "File Queued Event" do
        recorded = session.telemetry.event?(Events::FileQueued)

        test "Not recorded" do
          refute(recorded)
        end
      end

      context "File Executed Event" do
        recorded = session.telemetry.event?(Events::FileExecuted)

        test "Not recorded" do
          refute(recorded)
        end
      end

      context "Isolate" do
        isolate = session.isolate

        test "File isn't executed" do
          refute(isolate.executed?(file_path))
        end
      end
    end
  end
end
