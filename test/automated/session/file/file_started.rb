require_relative '../../automated_init'

context "Session" do
  context "File" do
    context "File Started Event" do
      session = Session.new

      control_path = Controls::File.example

      session.file(control_path)

      context "File Started Event" do
        file_started = session.telemetry.one_event(Session::Events::FileStarted)

        test! "Recorded" do
          refute(file_started.nil?)
        end

        context "Attributes" do
          context "Path" do
            path = file_started.path

            comment path.inspect
            detail "Control: #{path.inspect}"

            test do
              assert(path == control_path)
            end
          end
        end
      end

    ensure
      File.unlink(control_path) if File.exist?(control_path)
    end
  end
end
