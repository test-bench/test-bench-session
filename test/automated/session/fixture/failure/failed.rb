require_relative '../../../automated_init'

context "Session" do
  context "Fixture" do
    context "Failure" do
      context "Failed" do
        session = Session.new

        control_result = Controls::Result.failure

        fixture_name = Controls::Fixture::Name.example

        result = session.fixture(fixture_name) do
          session.record_failure
        end

        test! do
          assert(result == control_result)
        end

        context "Fixture Finished Event" do
          recorded = session.telemetry.one_event?(Session::Events::FixtureFinished, result:)

          test! "Recorded" do
            assert(recorded)
          end
        end
      end
    end
  end
end
