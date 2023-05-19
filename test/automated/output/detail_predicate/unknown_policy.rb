require_relative '../../automated_init'

context "Output" do
  context "Detail Predicate" do
    context "Unknown Policy" do
      policy = :unknown

      output = Session::Output.new

      output.detail_policy = policy

      test "Is an error" do
        assert_raises(Session::Output::Detail::Error) do
          output.detail?
        end
      end
    end
  end
end
