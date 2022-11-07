require_relative '../../automated_init'

context "Session" do
  context "Assert" do
    context "Failure" do
      session = Session.new

      control_result = Controls::Result.failure

      control_path = Controls::Failure::Path.example
      control_line_number = Controls::Failure::LineNumber.example

      control_message = Session.assertion_failure_message

      begin
        session.assert(control_result, control_path, control_line_number)
      rescue Session::Failure => failure
      end

      context "Exception" do
        test! "Raised" do
          refute(failure.nil?)
        end

        context "Message" do
          message = failure.message

          comment message.inspect
          detail "Control: #{control_message}"

          test do
            assert(message == control_message)
          end
        end
      end

      context "Session" do
        asserted = session.asserted?

        test "Asserted" do
          assert(asserted)
        end
      end

      context "Failed Event" do
        failed = session.telemetry.one_event(Session::Events::Failed)

        test! "Recorded" do
          refute(failed.nil?)
        end

        context "Attributes" do
          context "Message" do
            message = failed.message

            comment message.inspect
            detail "Control: #{control_message}"

            test do
              assert(message == control_message)
            end
          end

          context "Path" do
            path = failed.path

            comment path.inspect
            detail "Control: #{control_path}"

            test do
              assert(path == control_path)
            end
          end

          context "Line Number" do
            line_number = failed.line_number

            comment line_number.inspect
            detail "Control: #{control_line_number}"

            test do
              assert(line_number == control_line_number)
            end
          end
        end
      end
    end
  end
end
