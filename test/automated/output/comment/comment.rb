require_relative '../../automated_init'

context "Output" do
  context "Comment" do
    commented = Controls::Events::Commented.example

    text = "#{commented.text}\n"

    {
      Session::Output::Mode.initial => text,
      Session::Output::Mode.pending => text,
      Session::Output::Mode.passing => text,
      Session::Output::Mode.failing => text
    }.each do |mode, control_text|
      output = Controls::Output.example(mode:)

      context "Handle Commented Event" do
        output.handle(commented)

        context "Written Text" do
          writer = output.writer
          written_text = writer.written_text

          comment written_text
          detail "Control:", control_text

          test do
            assert(writer.written?(control_text))
          end
        end
      end
    end
  end
end
