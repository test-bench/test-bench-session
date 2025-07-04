require_relative '../automated_init'

context "Substitute" do
  context "Trace Matching" do
    substitute = Substitute.build

    control_title = Controls::Title.example
    substitute.trace.push(control_title)

    comment_text = Controls::Text::Comment.example
    substitute.comment(comment_text)

    context "Titles Match" do
      titles_match = substitute.event?(Events::Commented, control_title, comment_text)

      test do
        assert(titles_match)
      end
    end

    context "Titles Don't Match" do
      other_title = Controls::Title.other_example

      titles_match = substitute.event?(Events::Commented, other_title, comment_text)

      test do
        refute(titles_match)
      end
    end
  end
end
