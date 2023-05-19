require_relative '../automated_init'

context "Output" do
  context "Register Telemetry" do
    telemetry = Telemetry.new

    device = Controls::Output::Device.example
    styling = Controls::Output::Styling.random
    detail = Controls::Output::Detail.random

    output = Session::Output.register(telemetry, device:, styling:, detail:)

    test! "Registered" do
      assert(telemetry.registered?(output))
    end

    context "Configured" do
      comment output.class.name

      configured = output.instance_of?(Session::Output) &&
        output.writer.device == device &&
        output.writer.styling == styling &&
        output.detail == detail

      test do
        assert(configured)
      end
    end
  end
end
