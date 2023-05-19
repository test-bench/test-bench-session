require_relative '../../../automated_init'

context "Output Branching" do
  context "Merge" do
    context "Failure" do
      result = Controls::Result.failure

      output = Session::Output.new

      output.branch

      failing_data = Controls::Output::Data.example
      output.failing_writer.write(failing_data)
      comment "Failing Branch Data: #{failing_data.inspect}"

      passing_data = Controls::Output::Data.random
      output.passing_writer.write(passing_data)
      detail "Passing Branch Data: #{passing_data.inspect}"

      output.merge(result)

      context "Next Passing Writer" do
        passing_writer = output.passing_writer

        context "Written Data" do
          written_data = passing_writer.device.written_data

          comment written_data.inspect
          detail "Control: #{failing_data.inspect}"

          test do
            assert(passing_writer.written?(failing_data))
          end
        end
      end
    end
  end
end
