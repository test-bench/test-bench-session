require_relative '../../../automated_init'

context "Output" do
  context "Writer" do
    context "Indent" do
      context "Successive Invocations" do
        writer = Session::Output::Writer.new

        writer.indentation_depth = 1

        writer
          .indent
          .indent

        context "Indentation is written" do
          written_text = writer.device.written_data
          control_text = '    '

          comment written_text.inspect
          detail "Control Text: #{control_text.inspect}"

          test do
            assert(writer.written?(control_text))
          end
        end
      end
    end
  end
end
