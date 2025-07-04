require_relative '../../automated_init'

context "Session" do
  context "Test" do
    context "Optional Title Omitted" do
      session = Session.new

      session.test {}

      context "Test Started Event" do
        test_started = session.telemetry.one_event(Events::TestStarted)

        context "Title Attribute" do
          title = test_started.title

          test "Not set" do
            assert(title.nil?)
          end
        end
      end

      context "Test Finished Event" do
        test_finished = session.telemetry.one_event(Events::TestFinished)

        context "Title Attribute" do
          title = test_finished.title

          test "Not set" do
            assert(title.nil?)
          end
        end
      end
    end
  end
end
