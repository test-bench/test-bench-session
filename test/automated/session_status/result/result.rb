require_relative '../../automated_init'

context "Session Status" do
  context "Result" do
    context "Passed" do
      control_result = Result.passed

      status = Controls::Status::Passed.example

      result = status.result

      comment result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end

    context "Failed" do
      control_result = Result.failed

      status = Controls::Status::Failed.example

      result = status.result

      comment result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end

    context "None" do
      control_result = Result.none

      status = Controls::Status::None.example

      result = status.result

      comment result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end

    context "Aborted" do
      control_result = Result.aborted

      status = Controls::Status::Aborted.example

      result = status.result

      comment result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end

    context "Incomplete" do
      control_result = Result.incomplete

      status = Controls::Status::Incomplete.example

      result = status.result

      comment result.inspect
      detail "Control: #{control_result.inspect}"

      test do
        assert(result == control_result)
      end
    end
  end
end
