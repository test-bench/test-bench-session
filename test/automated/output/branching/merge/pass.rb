require_relative '../../../automated_init'

context "Output Branching" do
  context "Merge" do
    context "Pass" do
      result = Controls::Result.pass

      output = Session::Output.new

      output.branch

      passing_data = Controls::Output::Data.example
      output.passing_writer.write(passing_data)
      comment "Passing Branch Data: #{passing_data.inspect}"

      failing_data = Controls::Output::Data.random
      output.failing_writer.write(failing_data)
      detail "Failing Branch Data: #{failing_data.inspect}"

      output.merge(result)

      context "Next Passing Writer" do
        passing_writer = output.passing_writer

        context "Written Data" do
          written_data = passing_writer.device.written_data

          comment written_data.inspect
          detail "Control: #{passing_data.inspect}"

          test do
            assert(passing_writer.written?(passing_data))
          end
        end
      end
    end
  end
end
