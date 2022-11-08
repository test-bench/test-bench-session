require_relative '../../../../automated_init'

context "Session" do
  context "Context" do
    context "Variant" do
      context "Failure" do
        context "Exception" do
          session = Session.new

          control_exception = Controls::Exception.example

          begin
            session.context! do
              raise control_exception
            end
          rescue Controls::Exception::Example => exception
          end

          test! "Not rescued" do
            assert(exception == control_exception)
          end

          context "Context Finished Event" do
            recorded = session.telemetry.one_event?(Session::Events::ContextFinished)

            test! "Recorded" do
              assert(recorded)
            end
          end
        end
      end
    end
  end
end
