require_relative '../../../automated_init'

context "Output" do
  context "Interactive Buffer" do
    context "Viewport" do
      context "Write" do
        width, height = 3, 3

        [
          ["No Newline, No Scroll Rows, Within Capacity", '.', 1, 0, 0, 0, 0, 1, 0],
          ["No Newline, No Scroll Rows, Reaches Capacity", '......', 6, 0, 0, 0, 2, 0, 0],
          ["No Newline, No Scroll Rows, Exceeds Capacity", '.......', 6, 0, 0, 0, 2, 0, 0],
          ["Newline, No Scroll Rows, Within Capacity", ".\n", 2, 0, 0, 0, 1, 0, 0],
          ["Newline, No Scroll Rows, Reaches Capacity", "....\n", 5, 0, 0, 0, 2, 0, 0],
          ["Newline, No Scroll Rows, Exceeds Capacity", "......\n", 6, 0, 0, 0, 2, 0, 0],

          ["No Newline, One Scroll Row, Within Capacity", '.......', 7, 0, 0, 1, 2, 1, 1],
          ["No Newline, One Scroll Row, Reaches Capacity", '.........', 9, 0, 0, 1, 2, 0, 0],
          ["No Newline, One Scroll Row, Exceeds Capacity", '..........', 9, 0, 0, 1, 2, 0, 0],
          ["Newline, One Scroll Row, Within Capacity", "....\n", 5, 0, 0, 1, 2, 0, 1],
          ["Newline, One Scroll Row, Reaches Capacity", ".......\n", 8, 0, 0, 1, 2, 0, 0],
          ["Newline, One Scroll Row, Exceeds Capacity", ".........\n", 9, 0, 0, 1, 2, 0, 0],

          ["Escape Sequence (Reset)", "\e[m", 3, 0, 0, 0, 0, 0, 0],
          ["Escape Sequence (One Digit)", "\e[1A", 4, 0, 0, 0, 0, 0, 0],
          ["Escape Sequence (Multiple Digits)", "\e[11;22A", 8, 0, 0, 0, 0, 0, 0],
          ["Contains Escape Sequences", ".\e[1;2A.\e[2;1B.", 15, 0, 0, 0, 1, 0, 0],
        ].each do |title, text, control_bytes_written, initial_row, initial_column, initial_scroll_rows, control_row, control_column, control_scroll_rows_remaining|
          context "#{title}" do
            viewport = Session::Output::Writer::Buffer::Interactive::Viewport.build(width, height, initial_row, initial_column, initial_scroll_rows)

            bytes_written = viewport.write(text)

            context "Bytes Written" do
              comment bytes_written.inspect
              detail "Control: #{control_bytes_written.inspect}"

              test do
                assert(bytes_written == control_bytes_written)
              end
            end

            context "Row" do
              row = viewport.row

              comment row.inspect
              detail "Control: #{control_row.inspect}"

              test do
                assert(row == control_row)
              end
            end

            context "Column" do
              column = viewport.column

              comment column.inspect
              detail "Control: #{control_column.inspect}"

              test do
                assert(column == control_column)
              end
            end

            context "Scroll Rows Remaining" do
              scroll_rows_remaining = viewport.scroll_rows_remaining

              comment scroll_rows_remaining.inspect
              detail "Control: #{control_scroll_rows_remaining.inspect}"

              test do
                assert(scroll_rows_remaining == control_scroll_rows_remaining)
              end
            end
          end
        end
      end
    end
  end
end

