require_relative '../automated_init'

context "Substitute" do
  context "File" do
    substitute = Session::Substitute.build

    control_result = Controls::Result.random
    comment "Result: #{control_result}"
    substitute.result = control_result

    path = Controls::File::Path.random

    begin
      result = substitute.file(path)
    rescue Errno::ENOENT => file_open_error
    end

    test! do
      assert(result == result)
    end

    test "Doesn't open the file" do
      assert(file_open_error.nil?)
    end

    context "File Started Event" do
      recorded = substitute.telemetry.one_event?(Session::Events::FileStarted, path:)

      test "Recorded" do
        assert(recorded)
      end
    end

    context "File Finished Event" do
      recorded = substitute.telemetry.one_event?(Session::Events::FileFinished, path:, result:)

      test "Recorded" do
        assert(recorded)
      end
    end
  end
end
