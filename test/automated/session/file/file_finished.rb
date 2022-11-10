require_relative '../../automated_init'

context "Session" do
  context "File" do
    context "File Finished Event" do
      session = Session.new

      control_path = Controls::File.example

      session.file(control_path)

      context "File Finished Event" do
        file_finished = session.telemetry.one_event(Session::Events::FileFinished)

        test! "Recorded" do
          refute(file_finished.nil?)
        end

        context "Attributes" do
          context "Path" do
            path = file_finished.path

            comment path.inspect
            detail "Control: #{path.inspect}"

            test do
              assert(path == control_path)
            end
          end

          context "Result" do
            result = file_finished.result

            comment result.inspect

            test "Set" do
              refute(result.nil?)
            end
          end
        end
      end

    ensure
      File.unlink(control_path) if File.exist?(control_path)
    end
  end
end
