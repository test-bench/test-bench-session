require_relative '../../automated_init'

context "Session" do
  context "Execute File" do
    apex_directory = Controls::Path::ApexDirectory::Create.()
    comment "Apex directory: #{apex_directory.inspect}"

    file_path = Controls::Path::File::Create.()

    session = Session.new

    result = session.execute(file_path)

    context "File Queued Event" do
      file_queued = session.telemetry.one_event(Events::FileQueued)

      test! "Recorded" do
        refute(file_queued.nil?)
      end

      context "File Attribute" do
        file = file_queued.file
        control_file = file_path

        comment file.inspect
        detail "Control: #{control_file.inspect}"

        test do
          assert(file == control_file)
        end
      end
    end

    context "File Executed Event" do
      file_executed = session.telemetry.one_event(Events::FileExecuted)

      test! "Recorded" do
        refute(file_executed.nil?)
      end

      context "Attributes" do
        context "File" do
          file = file_executed.file
          control_file = file_path

          comment file.inspect
          detail "Control: #{control_file.inspect}"

          test do
            assert(file == control_file)
          end
        end

        context "Result" do
          control_result = result
          result = file_executed.result

          comment result.inspect
          detail "Control: #{control_result.inspect}"

          test do
            assert(result == control_result)
          end
        end
      end
    end

  ensure
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
end
