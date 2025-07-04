require_relative '../automated_init'

context "Session" do
  context "Inspect" do
    session = Session.build

    not_inspected_text = '@telemetry=(not inspected)'

    context "Not Raw" do
      text = session.inspect

      comment text

      context "Telemetry Dependency" do
        not_shown = text.include?(not_inspected_text)

        test "Not shown" do
          assert(not_shown)
        end
      end
    end

    context "Raw" do
      text = session.inspect(raw: true)

      comment text

      context "Telemetry Dependency" do
        not_shown = text.include?(not_inspected_text)

        test "Shown" do
          refute(not_shown)
        end
      end
    end
  end
end
