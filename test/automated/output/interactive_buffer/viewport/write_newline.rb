require_relative '../../../automated_init'

context "Output" do
  context "Interactive Buffer" do
    context "Viewport" do
      context "Write Newline" do
        width, height = 3, 3

        [
          ["Top Left, No Scroll Rows", 0, 0, 0, 1, 0, 0, true],
          ["Top Right, No Scroll Rows", 0, 2, 0, 1, 0, 0, true],
          ["Middle Left, No Scroll Rows", 1, 0, 0, 2, 0, 0, true],
          ["Middle Right, No Scroll Rows", 1, 2, 0, 2, 0, 0, true],
          ["Bottom Left, No Scroll Rows", 2, 0, 0, 2, 0, 0, false],
          ["Bottom Right, No Scroll Rows", 2, 2, 0, 2, 2, 0, false],

          ["Top Left, One Scroll Row", 0, 0, 1, 1, 0, 1, true],
          ["Top Right, One Scroll Row", 0, 2, 1, 1, 0, 1, true],
          ["Middle Left, One Scroll Row", 1, 0, 1, 2, 0, 1, true],
          ["Middle Right, One Scroll Row", 1, 2, 1, 2, 0, 1, true],
          ["Bottom Left, One Scroll Row", 2, 0, 1, 2, 0, 0, true],
          ["Bottom Right, One Scroll Row", 2, 2, 1, 2, 0, 0, true],

          ["Top Left, Two Scroll Rows", 0, 0, 2, 1, 0, 2, true],
          ["Top Right, Two Scroll Rows", 0, 2, 2, 1, 0, 2, true],
          ["Middle Left, Two Scroll Rows", 1, 0, 2, 2, 0, 2, true],
          ["Middle Right, Two Scroll Rows", 1, 2, 2, 2, 0, 2, true],
          ["Bottom Left, Two Scroll Rows", 2, 0, 2, 2, 0, 1, true],
          ["Bottom Right, Two Scroll Rows", 2, 2, 2, 2, 0, 1, true],
        ].each do |title, initial_row, initial_column, initial_scroll_rows, control_row, control_column, control_scroll_rows_remaining, control_written|
          context "#{title}" do
            viewport = Session::Output::Writer::Buffer::Interactive::Viewport.build(width, height, initial_row, initial_column, initial_scroll_rows)

            bytes_written = viewport.write_newline

            context "Bytes Written" do
              control_bytes_written = control_written ? 1 : 0

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
