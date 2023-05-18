require_relative '../../../automated_init'

context "Output" do
  context "Interactive Buffer" do
    context "Viewport" do
      context "Write Text" do
        width, height = 3, 3

        [
          ["Top Left, No Scroll Rows, One Character", '.', 1, 0, 0, 0, 0, 1, 0],
          ["Top Right, No Scroll Rows, One Character", '.', 1, 0, 2, 0, 1, 0, 0],
          ["Middle Left, No Scroll Rows, One Character", '.', 1, 1, 0, 0, 1, 1, 0],
          ["Middle Right, No Scroll Rows, One Character", '.', 1, 1, 2, 0, 2, 0, 0],
          ["Bottom Left, No Scroll Rows, One Character", '.', 0, 2, 0, 0, 2, 0, 0],
          ["Bottom Right, No Scroll Rows, One Character", '.', 0, 2, 2, 0, 2, 2, 0],

          ["Bottom Left, One Scroll Row, One Character", '.', 1, 2, 0, 1, 2, 1, 1],
          ["Bottom Right, One Scroll Row, One Character", '.', 1, 2, 2, 1, 2, 0, 0],

          ["Bottom Left, Two Scroll Rows, One Character", '.', 1, 2, 0, 2, 2, 1, 2],
          ["Bottom Right, Two Scroll Rows, One Character", '.', 1, 2, 2, 2, 2, 0, 1],

          ["Top Left, No Scroll Rows, One Line Plus One Character", '....', 4, 0, 0, 0, 1, 1, 0],
          ["Top Right, No Scroll Rows, One Line Plus One Character", '....', 4, 0, 2, 0, 2, 0, 0],
          ["Middle Left, No Scroll Rows, One Line Plus One Character", '....', 3, 1, 0, 0, 2, 0, 0],
          ["Middle Right, No Scroll Rows, One Line Plus One Character", '....', 1, 1, 2, 0, 2, 0, 0],
          ["Bottom Left, No Scroll Rows, One Line Plus One Character", '....', 0, 2, 0, 0, 2, 0, 0],
          ["Bottom Right, No Scroll Rows, One Line Plus One Character", '....', 0, 2, 2, 0, 2, 2, 0],

          ["Bottom Left, One Scroll Row, One Line Plus One Character", '....', 3, 2, 0, 1, 2, 0, 0],
          ["Bottom Right, One Scroll Row, One Line Plus One Character", '....', 1, 2, 2, 1, 2, 0, 0],

          ["Bottom Left, Two Scroll Rows, One Line Plus One Character", '....', 4, 2, 0, 2, 2, 1, 1],
          ["Bottom Right, Two Scroll Rows, One Line Plus One Character", '....', 4, 2, 2, 2, 2, 0, 0],
          ["Bottom Right, Two Scroll Rows, One Line Plus Two Characters", '.....', 4, 2, 2, 2, 2, 0, 0],

          ["Escape Sequence", "\e..", 3, 0, 0, 0, 0, 0, 0]
        ].each do |title, text, control_bytes_written, initial_row, initial_column, initial_scroll_rows, control_row, control_column, control_scroll_rows_remaining|
          context "#{title}" do
            viewport = Session::Output::Writer::Buffer::Interactive::Viewport.build(width, height, initial_row, initial_column, initial_scroll_rows)

            bytes_written = viewport.write_text(text)

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

