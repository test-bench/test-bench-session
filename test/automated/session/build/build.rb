require_relative '../../automated_init'

context "Session" do
  context "Build" do
    session = Session.build

    context "Telemetry Dependency" do
      telemetry = session.telemetry

      context "Configured" do
        configured = telemetry.instance_of?(Telemetry)

        test do
          assert(configured)
        end
      end
    end
  end
end
