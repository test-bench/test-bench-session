require_relative '../../../automated_init'

context "Session" do
  context "Test" do
    context "Failure" do
      context "No Assertion" do
        session = Session.new

        control_message = Session.no_assertion_message
        detail "Message: #{control_message}"

        control_result = Controls::Result.failure

        result = session.test do
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
          end
        end
      end
    end
  end
end
