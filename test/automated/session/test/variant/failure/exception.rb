require_relative '../../../../automated_init'

context "Session" do
  context "Test" do
    context "Variant" do
      context "Failure" do
        context "Exception" do
          session = Session.new

          control_exception = Controls::Exception.example

          begin
            session.test!(__FILE__, __LINE__) do
              raise control_exception
            end
          rescue Controls::Exception::Example => exception
          end

          test! "Not rescued" do
            assert(exception == control_exception)
          end

          context "Test Finished Event" do
            recorded = session.telemetry.one_event?(Session::Events::TestFinished)

            test! "Recorded" do
              assert(recorded)
            end
          end
        end
      end
    end
  end
end
