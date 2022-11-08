require_relative '../../../automated_init'

context "Session" do
  context "Test" do
    context "Failure" do
      context "No Assertion" do
        session = Session.new

        control_path = Controls::Failure::Path.example
        control_line_number = Controls::Failure::LineNumber.example

        control_message = Session.no_assertion_message
        detail "Message: #{control_message}"

        control_result = Controls::Result.failure

        result = session.test(control_path, control_line_number) do
          #
        end

        test! do
          assert(result == control_result)
        end

        context "Test Finished Event" do
          recorded = session.telemetry.one_event?(Session::Events::TestFinished, result:)

          test! "Recorded" do
            assert(recorded)
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
              detail "Control: #{control_message.inspect}"

              test do
                assert(message == control_message)
              end
            end

            context "Path" do
              path = failed.path

              comment path.inspect
              detail "Control: #{control_path.inspect}"

              test do
                assert(path == control_path)
              end
            end

            context "Line Number" do
              line_number = failed.line_number

              comment line_number.inspect
              detail "Control: #{control_line_number.inspect}"

              test do
                assert(line_number == control_line_number)
              end
            end
          end
        end
      end
    end
  end
end
