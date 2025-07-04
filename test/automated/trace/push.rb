require_relative '../automated_init'

context "Trace" do
  context "Push Title" do
    title = Controls::Title.example

    context "Empty Trace" do
      trace = Trace.new

      trace.push(title)

      entries = trace.entries
      control_entries = [title]

      comment entries.inspect
      detail "Control: #{control_entries.inspect}"

      test "Pushed" do
        assert(entries == control_entries)
      end
    end

    context "Non-Empty Trace" do
      trace = Trace.new

      bottom_title = "Bottom Title"

      trace.entries = [bottom_title]

      trace.push(title)

      entries = trace.entries
      control_entries = [bottom_title, title]

      comment entries.inspect
      detail "Control: #{control_entries.inspect}"

      test "Pushed" do
        assert(entries == control_entries)
      end
    end
  end
end
