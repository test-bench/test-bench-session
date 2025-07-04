require_relative '../../automated_init'

context "Isolate" do
  context "Subprocess" do
    context "Start and Stop" do
      isolate = Isolate.new

      original_subprocess_sequence = Controls::Sequence.example
      isolate.subprocess_sequence = original_subprocess_sequence

      assert(isolate.subprocess_id.nil?)

      context "Start" do
        isolate.start

        context "Subprocess ID" do
          subprocess_id = isolate.subprocess_id

          comment subprocess_id.inspect

          test "Set" do
            assert(subprocess_id.instance_of?(Integer))
          end
        end

        context "Process Sequence" do
          subprocess_sequence = isolate.subprocess_sequence

          control_subprocess_sequence = original_subprocess_sequence + 1

          comment "Before: #{original_subprocess_sequence.inspect}"
          comment "After: #{subprocess_sequence.inspect}"
          detail "Control: #{control_subprocess_sequence.inspect}"

          test "Incremented" do
            assert(subprocess_sequence == control_subprocess_sequence)
          end
        end

        context "Status" do
          status = isolate.status
          control_status = Isolate::Status.active

          comment status.inspect
          detail "Control: #{control_status.inspect}"

          test do
            assert(status == control_status)
          end
        end
      end

      context "Stop" do
        exit_status = isolate.stop

        context "Subprocess ID" do
          subprocess_id = isolate.subprocess_id

          test "Cleared" do
            assert(subprocess_id.nil?)
          end
        end

        context "Status" do
          status = isolate.status
          control_status = Isolate::Status.stopped

          comment status.inspect
          detail "Control: #{control_status.inspect}"

          test do
            assert(status == control_status)
          end
        end

        context "Subprocess Exit Status" do
          comment exit_status.inspect

          test "Zero" do
            assert(exit_status.zero?)
          end
        end
      end
    end
  end
end
