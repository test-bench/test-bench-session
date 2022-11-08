require_relative '../../automated_init'

context "Session" do
  context "Test" do
    context "Optional Title Omitted" do
      session = Session.new

      session.test(__FILE__, __LINE__) do
        #
      end

      context "Test Started Event" do
        test_started = session.telemetry.one_event(Session::Events::TestStarted)

        test! "Recorded" do
          refute(test_started.nil?)
        end

        context "Title Attributes" do
          title = test_started.title

          comment title.inspect

          test "Not set" do
            assert(title.nil?)
          end
        end
      end

      context "Test Finished Event" do
        test_finished = session.telemetry.one_event(Session::Events::TestFinished)

        test! "Recorded" do
          refute(test_finished.nil?)
        end

        context "Title Attributes" do
          title = test_finished.title

          comment title.inspect

          test "Not set" do
            assert(title.nil?)
          end
        end
      end
    end
  end
end
