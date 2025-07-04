require_relative "../automated_init"

context "Trace" do
  context "Enumerable" do
    control_entries = [
      Controls::Title.example,
      Controls::Title.other_example,
      Controls::Text.example
    ]

    trace = Trace.new

    trace.entries = control_entries

    context "Enumerate" do
      entries = trace.to_a

      test do
        assert(entries == control_entries)
      end
    end

    context "Get Enumerator" do
      enumerator = trace.each

      entries = enumerator.to_a

      test do
        assert(entries == control_entries)
      end
    end
  end
end
