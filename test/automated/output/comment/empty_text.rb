require_relative '../../automated_init'

context "Output" do
  context "Comment" do
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
            commented = Controls::Events::Commented.example(quote:, heading:, text:)

            output = Controls::Output::Styling.example

            context "Handle Commented Event" do
              output.handle(commented)

              context "Written Text" do
                writer = output.writer
                written_text = writer.written_text

                control_text = <<~TEXT
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
            commented = Controls::Events::Commented.example(quote:, text:)

            output = Controls::Output::Styling.example

            context "Handle Commented Event" do
              output.handle(commented)

              context "Written Text" do
                writer = output.writer
                written_text = writer.written_text

                control_text = <<~TEXT
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
    end
  end
end
