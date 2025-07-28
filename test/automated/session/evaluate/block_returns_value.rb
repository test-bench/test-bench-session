require_relative '../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Block Returns A Value" do
      session = Session.new

      control_value = 'some-value'

      result = lambda {
        session.evaluate(Controls::Event::Pending.example) do
          return control_value
        end
      }.()

      comment result.inspect
      detail "Control: #{control_value.inspect}"

      test do
        assert(result == control_value)
      end
    end
  end
end
