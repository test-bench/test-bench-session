require_relative '../../../automated_init'

context "Output" do
  context "Writer" do
    context "Substitute" do
      context "Buffering Mode" do
        substitute = Session::Output::Writer::Substitute.build

        substitute.sync = false

        text = Controls::Output::Text.example
        substitute.print(text)

        context "Written Text" do
          written_text = substitute.written_text

          comment written_text.inspect

          test "Not written" do
            refute(substitute.written?)
          end
        end
      end
    end
  end
end
