require_relative '../../automated_init'

context "Output" do
  context "Writer" do
    context "Raw Write" do
      writer = Session::Output::Writer.new

      context "Write Data" do
        data = Controls::Output::Data.example

        writer.write!(data)

        detail "Written Data: #{data.inspect}"

        context "Device" do
          device = writer.device

          comment "Written Data: #{device.written_data.inspect}"

          test "Received the written data" do
            assert(device.written?(data))
          end
        end

        context "Alternate Receiver" do
          alternate_device = writer.alternate_device

          comment "Written Data: #{alternate_device.written_data.inspect}"

          test "Received the written data" do
            assert(alternate_device.written?(data))
          end
        end
      end
    end
  end
end
