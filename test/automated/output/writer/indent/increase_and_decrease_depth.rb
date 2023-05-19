require_relative '../../../automated_init'

context "Output" do
  context "Writer" do
    context "Indent" do
      context "Increase and Decrease Depth" do
        writer = Session::Output::Writer.new

        22.times do
          writer.indent!
        end

        11.times do
          writer.deindent!
        end

        context "Indentation Depth" do
          indentation_depth = writer.indentation_depth
          control_indentation_depth = 11

          comment indentation_depth.inspect
          detail "Control: #{control_indentation_depth.inspect}"

          test do
            assert(indentation_depth == control_indentation_depth)
          end
        end
      end
    end
  end
end
