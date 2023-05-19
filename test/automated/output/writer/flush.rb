require_relative '../../automated_init'

context "Output" do
  context "Writer" do
    context "Flush" do
      writer = Session::Output::Writer.new

      data = Controls::Output::Data.example
      writer.buffer.receive(data)
      detail "Buffered Data: #{data.inspect}"

      writer.flush

      context "Buffer's Contents" do
        contents = writer.buffer.contents

        comment contents.inspect

        flushed = contents.empty?

        test "Flushed" do
          assert(flushed)
        end
      end

      context "Writer's Device" do
        device = writer.device

        context "Written" do
          written_data = device.written_data

          comment written_data.inspect

          test do
            assert(device.written?(data))
          end
        end
      end

      context "Writer's Alternate Device" do
        alternate_device = writer.alternate_device

        context "Written" do
          written_data = alternate_device.written_data

          comment written_data.inspect

          test do
            assert(alternate_device.written?(data))
          end
        end
      end
    end
  end
end
