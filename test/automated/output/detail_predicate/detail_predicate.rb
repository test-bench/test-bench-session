require_relative '../../automated_init'

context "Output" do
  context "Detail Predicate" do
    [
      ["On", Session::Output::Detail.on, true, true, true, true],
      ["Off", Session::Output::Detail.off, false, false, false, false],
      ["Detect", Session::Output::Detail.failure, true, false, false, true]
    ].each do |title, policy, initial_value, pending_value, passing_value, failing_value|
      context "Policy: #{title}" do
        output = Session::Output.new

        output.detail_policy = policy

        context "Initial Mode" do
          output.mode = Session::Output::Mode.initial

          details = output.detail?

          comment details.inspect
          detail "Control: #{initial_value}"

          test do
            assert(details == initial_value)
          end
        end

        context "Pending Mode" do
          output.mode = Session::Output::Mode.pending

          details = output.detail?

          comment details.inspect
          detail "Control: #{pending_value}"

          test do
            assert(details == pending_value)
          end
        end

        context "Passing Mode" do
          output.mode = Session::Output::Mode.passing

          details = output.detail?

          comment details.inspect
          detail "Control: #{passing_value}"

          test do
            assert(details == passing_value)
          end
        end

        context "Failing Mode" do
          output.mode = Session::Output::Mode.failing

          details = output.detail?

          comment details.inspect
          detail "Control: #{failing_value}"

          test do
            assert(details == failing_value)
          end
        end
      end
    end
  end
end
