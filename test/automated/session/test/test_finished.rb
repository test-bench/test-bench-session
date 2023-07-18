require_relative '../../automated_init'

context "Session" do
  context "Test" do
    context "Test Finished Event" do
      session = Session.new

      control_title = Controls::Title::Test.example

      session.test(control_title) do
        #
      end

      context "Test Finished Event" do
        test_finished = session.telemetry.one_event(Session::Events::TestFinished)

        test! "Recorded" do
          refute(test_finished.nil?)
        end

        context "Attributes" do
          context "Title" do
            title = test_finished.title

            comment title.inspect
            detail "Control: #{control_title.inspect}"

            test do
              assert(title == control_title)
            end
          end

          context "Result" do
            result = test_finished.result

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
