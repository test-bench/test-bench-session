require_relative '../../automated_init'

context "Session" do
  context "Fixture" do
    context "Fixture Started Event" do
      session = Session.new

      fixture_name = Controls::Fixture::Name.example

      session.fixture(fixture_name) do
        #
      end

      context "Fixture Started Event" do
        fixture_started = session.telemetry.one_event(Session::Events::FixtureStarted)

        test! "Recorded" do
          refute(fixture_started.nil?)
        end

        context "Attributes" do
          context "Name" do
            name = fixture_started.name

            comment name.inspect
            detail "Control: #{fixture_name.inspect}"

            test do
              assert(name == fixture_name)
            end
          end
        end
      end
    end
  end
end
