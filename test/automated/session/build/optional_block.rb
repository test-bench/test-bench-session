require_relative '../../automated_init'

context "Session" do
  context "Build" do
    context "Optional Block Given" do
      control_value = Controls::Random.string
      block_argument = control_value

      session = Session.build do |arg|
        block_argument = arg
      end

      context "Block is executed" do
        block_executed = block_argument != control_value

        test do
          assert(block_executed)
        end
      end

      context "Block Argument" do
        session_telemetry = session.telemetry

        test "Session's telemetry" do
          assert(block_argument == session_telemetry)
        end
      end
    end
  end
end
