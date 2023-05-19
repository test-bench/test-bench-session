require_relative '../../automated_init'

context "Output" do
  context "Detail" do
    context "Empty Text" do
      text = ''
      empty_message = "\e[2;3m(empty)\e[0m"

      context "Heading" do
        heading = "Some Heading:"

        [
          ["Quoted", true],
          ["Not Quoted", false]
        ].each do |title, quote|
          context title do
            detailed = Controls::Events::Detailed.example(quote:, heading:, text:)

            output = Controls::Output::Styling.example

            output.writer.increase_indentation

            context "Handle Detailed Event" do
              output.handle(detailed)

              context "Written Text" do
                writer = output.writer
                written_text = writer.written_text

                control_text = <<-TEXT
  \e[1;4m#{heading}\e[0m
  #{empty_message}
                TEXT

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

      context "No Heading" do
        [
          ["Quoted", true],
          ["Not Quoted", false]
        ].each do |title, quote|
          context title do
            detailed = Controls::Events::Detailed.example(quote:, text:)

            output = Controls::Output::Styling.example

            output.writer.increase_indentation

            context "Handle Detailed Event" do
              output.handle(detailed)

              context "Written Text" do
                writer = output.writer
                written_text = writer.written_text

                control_text = "  #{empty_message}\n"

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
    end
  end
end
