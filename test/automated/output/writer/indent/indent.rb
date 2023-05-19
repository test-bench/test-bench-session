require_relative '../../../automated_init'

context "Output" do
  context "Writer" do
    context "Indent" do
      indentation_depth = 2
      detail "Indentation Depth: #{indentation_depth.inspect}"

      writer = Session::Output::Writer.new

      indentation_depth.times do
        writer.indent!
      end

      writer.indent

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
