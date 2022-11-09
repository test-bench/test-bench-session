require_relative '../../../automated_init'

context "Session" do
  context "Fixture" do
    context "Failure" do
      context "Exception" do
        session = Session.new

        control_exception = Controls::Exception.example

        fixture_name = Controls::Fixture::Name.example

        begin
          session.fixture(fixture_name) do
            raise control_exception
          end
        rescue Controls::Exception::Example => exception
        end

        test! "Not rescued" do
          assert(exception == control_exception)
        end

        context "Fixture Finished Event" do
          recorded = session.telemetry.one_event?(Session::Events::FixtureFinished)

          test! "Recorded" do
            assert(recorded)
          end
        end
      end
    end
  end
end
