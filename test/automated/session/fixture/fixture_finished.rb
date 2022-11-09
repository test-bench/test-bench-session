require_relative '../../automated_init'

context "Session" do
  context "Fixture" do
    context "Fixture Finished Event" do
      session = Session.new

      fixture_name = Controls::Fixture::Name.example

      session.fixture(fixture_name) do
        #
      end

      context "Fixture Finished Event" do
        fixture_finished = session.telemetry.one_event(Session::Events::FixtureFinished)

        test! "Recorded" do
          refute(fixture_finished.nil?)
        end

        context "Attributes" do
          context "Name" do
            name = fixture_finished.name

            comment name.inspect
            detail "Control: #{fixture_name.inspect}"

            test do
              assert(name == fixture_name)
            end
          end

          context "Result" do
            result = fixture_finished.result

            comment result.inspect

            test "Set" do
              refute(result.nil?)
            end
          end
        end
      end
    end
  end
end
