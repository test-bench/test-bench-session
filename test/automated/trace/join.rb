require_relative "../automated_init"

context "Trace" do
  context "Join" do
    title = Controls::Title.example
    other_title = Controls::Title.other_example
    text = Controls::Text.example

    trace = Trace.new

    trace.entries = [title, other_title, text]

    context "Optional Delimiter Specified" do
      delimiter = '+'

      control_text = [
        title,
        delimiter,
        other_title,
        delimiter,
        text
      ].join

      joined_text = trace.join(delimiter)

      comment joined_text.inspect
      detail "Control: #{control_text.inspect}"

      test do
        assert(joined_text == control_text)
      end
    end

    context "Optional Delimiter Omitted" do
      control_text = [
        title,
        Trace.join_delimiter,
        other_title,
        Trace.join_delimiter,
        text
      ].join

      joined_text = trace.join

      comment joined_text.inspect
      detail "Control: #{control_text.inspect}"

      test do
        assert(joined_text == control_text)
      end
    end
  end
end
