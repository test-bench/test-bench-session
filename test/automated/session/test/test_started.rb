require_relative '../../automated_init'

context "Session" do
  context "Test" do
    context "Test Started Event" do
      session = Session.new

      control_title = Controls::Title::Test.example

      session.test(__FILE__, __LINE__, control_title) do
        #
      end

      context "Test Started Event" do
        test_started = session.telemetry.one_event(Session::Events::TestStarted)

        test! "Recorded" do
          refute(test_started.nil?)
        end

        context "Attributes" do
          context "Title" do
            title = test_started.title

            comment title.inspect
            detail "Control: #{control_title.inspect}"

            test do
              assert(title == control_title)
            end
          end
        end
      end
    end
  end
end
