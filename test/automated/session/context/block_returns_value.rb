require_relative '../../automated_init'

context "Session" do
  context "Context" do
    context "Block Returns A Value" do
      session = Session.new

      control_value = 'some-value'

      result = lambda {
        session.context(Controls::Title::Context.example) do
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
