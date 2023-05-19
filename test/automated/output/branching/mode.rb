require_relative '../../automated_init'

context "Output Branching" do
  context "Mode" do
    [
      ["Initial", Session::Output::Mode.initial, :initial?],
      ["Pending", Session::Output::Mode.pending, :pending?],
      ["Passing", Session::Output::Mode.passing, :passing?],
      ["Failing", Session::Output::Mode.failing, :failing?]
    ].each do |title, mode, affirmative_predicate|
      context "#{title}" do
        output = Session::Output.new

        output.mode = mode

        context "Predicates" do
          context "Initial" do
            value = output.initial?

            control_value = affirmative_predicate == :initial?

            comment value.inspect
            detail "Control: #{control_value.inspect}"

            test do
              assert(value == control_value)
            end
          end

          context "Pending" do
            value = output.pending?

            control_value = affirmative_predicate == :pending?

            comment value.inspect
            detail "Control: #{control_value.inspect}"

            test do
              assert(value == control_value)
            end
          end

          context "Passing" do
            value = output.passing?

            control_value = affirmative_predicate == :passing?

            comment value.inspect
            detail "Control: #{control_value.inspect}"

            test do
              assert(value == control_value)
            end
          end

          context "Failing" do
            value = output.failing?

            control_value = affirmative_predicate == :failing?

            comment value.inspect
            detail "Control: #{control_value.inspect}"

            test do
              assert(value == control_value)
            end
          end
        end
      end
    end
  end
end
