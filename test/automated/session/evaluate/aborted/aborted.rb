require_relative '../../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Aborted" do
      session = Session.new

      pending_event = Controls::Event::Pending.example

      control_location = Controls::Backtrace::Location.example

      session.format_backtrace.set_location(control_location)

      exception = Controls::Exception.example

      begin
        session.evaluate(pending_event) do
          raise exception
        end
      rescue Controls::Exception::SomeException
      end

      context "Aborted Event" do
        aborted = session.telemetry.one_event(Events::Aborted)

        test! "Recorded" do
          refute(aborted.nil?)
        end

        context "Message" do
          message = aborted.message
          detailed_message = exception.detailed_message

          comment message.inspect
          detail "Detailed Message: #{detailed_message.inspect}"

          test do
            assert(message == detailed_message)
          end
        end

        context "Location" do
          location = aborted.location

          comment location.inspect
          detail "Control: #{control_location.inspect}"

          test do
            assert(location == control_location)
          end
        end
      end

      context "Pending Event" do
        test "Recorded" do
          assert(session.telemetry.recorded?(pending_event))
        end

        context "Result Attribute" do
          result = pending_event.result
          control_result = Result.aborted

          comment result.inspect
          detail "Control Result: #{control_result.inspect}"

          test do
            assert(result == control_result)
          end
        end
      end
    end
  end
end
