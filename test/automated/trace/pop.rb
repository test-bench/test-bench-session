require_relative '../automated_init'

context "Trace" do
  context "Pop Title" do
    context "Empty Trace" do
      trace = Trace.new

      trace.pop

      entries = trace.entries

      comment entries.inspect

      test "Remains empty" do
        assert(entries.empty?)
      end
    end

    context "Non-Empty Trace" do
      trace = Trace.new

      control_title = "Bottom Title"

      trace.entries = [
        control_title,
        Controls::Title.example
      ]

      trace.pop

      entries = trace.entries
      control_entries = [control_title]

      comment entries.inspect
      detail "Control: #{control_entries.inspect}"

      test "Popped" do
        assert(entries == control_entries)
      end
    end
  end
end
