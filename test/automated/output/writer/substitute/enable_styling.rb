require_relative '../../../automated_init'

context "Output" do
  context "Writer" do
    context "Substitute" do
      context "Enable Styling" do
        style = Controls::Output::Style.example
        style_code = Controls::Output::Style::Code.example

        context "Enabled" do
          substitute = Session::Output::Writer::Substitute.build

          substitute.styling!

          substitute.style(style)

          context "Writes a control sequence" do
            written_text = substitute.written_data
            control_text = "\e[#{style_code}m"

            comment written_text.inspect
            detail "Control Text: #{control_text.inspect}"

            test do
              assert(substitute.written?(control_text))
            end
          end
        end

        context "Not Enabled" do
          substitute = Session::Output::Writer::Substitute.build

          substitute.style(style)

          test "No text written" do
            refute(substitute.written?)
          end
        end
      end
    end
  end
end
