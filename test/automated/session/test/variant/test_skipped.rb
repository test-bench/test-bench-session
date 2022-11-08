require_relative '../../../automated_init'

context "Session" do
  context "Test Variant" do
    context "Test Skipped" do
      session = Session.new

      control_title = Controls::Title::Test.example

      session.test!(__FILE__, __LINE__, control_title)

      context "Test Skipped Event" do
        test_skipped = session.telemetry.one_event(Session::Events::TestSkipped)

        test! "Recorded" do
          refute(test_skipped.nil?)
        end

        context "Attributes" do
          context "Title" do
            title = test_skipped.title

            comment title.inspect
            detail "Control: #{control_title.inspect}"

            test do
              assert(title == control_title)
            end
          end
        end
      end

      context "Test Started Event" do
        recorded = session.telemetry.event?(Session::Events::TestStarted)

        test "Not recorded" do
          refute(recorded)
        end
      end

      context "Test Finished Event" do
        recorded = session.telemetry.event?(Session::Events::TestFinished)

        test "Not recorded" do
          refute(recorded)
        end
      end
    end
  end
end
