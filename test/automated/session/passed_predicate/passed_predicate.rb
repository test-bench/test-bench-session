require_relative '../../automated_init'

context "Session" do
  context "Passed Predicated" do
    context "Passed" do
      session = Session.new

      session.record_assertion

      context "Assertion Sequence Increased And No Tests Were Skipped" do
        passed = session.passed?

        test do
          assert(passed)
        end
      end
    end

    context "Not Passed" do
      context "Failed" do
        session = Session.new

        session.record_failure

        passed = session.passed?

        test do
          refute(passed)
        end
      end

      context "No assertions" do
        session = Session.new

        passed = session.passed?

        test do
          refute(passed)
        end
      end

      context "Tests were skipped" do
        session = Session.new

        session.record_assertion
        session.record_skip

        passed = session.passed?

        test do
          refute(passed)
        end
      end
    end
  end
end
