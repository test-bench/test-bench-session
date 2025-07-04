require_relative '../automated_init'

context "Trace" do
  context "Match Predicate" do
    trace = Trace.new

    title = Controls::Title.example
    other_title = Controls::Title.other_example
    text = Controls::Text.example

    trace.entries = [
      title,
      other_title,
      text
    ]

    context "Affirmative" do
      context "All Entries Matched" do
        matched = trace.match?(title, other_title, text)

        test do
          assert(matched)
        end
      end

      context "Final Entry Matched" do
        matched = trace.match?(text)

        test do
          assert(matched)
        end
      end

      context "First And Final Entries Matched" do
        matched = trace.match?(title, text)

        test do
          assert(matched)
        end
      end
    end

    context "Negative" do
      context "Final Entry Isn't Matched" do
        matched = trace.match?(title, other_title)

        test do
          refute(matched)
        end
      end

      context "Titles Aren't In Order" do
        matched = trace.match?(other_title, title, text)

        test do
          refute(matched)
        end
      end

      context "Final Title Is Duplicated" do
        matched = trace.match?(title, other_title, text, text)

        test do
          refute(matched)
        end
      end
    end
  end
end
