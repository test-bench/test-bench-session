require_relative '../../automated_init'

context "Session" do
  context "Finish" do
    context "Finished Event" do
      session = Session.new

      control_process_count = Controls::Events::Finished.process_count

      control_result = !session.failed?

      session.finish(control_process_count)

      context "Finished Event" do
        finished = session.telemetry.one_event(Session::Events::Finished)

        test! "Recorded" do
          refute(finished.nil?)
        end

        context "Attributes" do
          context "Process Count" do
            process_count = finished.process_count

            comment process_count.inspect
            detail "Control: #{control_process_count.inspect}"

            test do
              assert(process_count == control_process_count)
            end
          end

          context "Result" do
            result = finished.result

            comment result.inspect
            detail "Control: #{control_result.inspect}"

            test do
              assert(result == control_result)
            end
          end
        end
      end
    end
  end
end
