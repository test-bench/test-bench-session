module TestBench
  class Session
    class Output
      class Writer
        module Buffer
          class Interactive
            Viewport = Struct.new(:width, :height, :row, :column, :scroll_rows, :rows_scrolled) do
              def self.build(width, height, row, column, scroll_rows=nil)
                scroll_rows ||= 0

                rows_scrolled = 0

                new(width, height, row, column, scroll_rows, rows_scrolled)
              end

              def self.null
                build(0, 0, 0, 0)
              end

              def write_text(text)
                if text.start_with?("\e")
                  return text.bytesize
                end

                written_text = text[0...capacity]

                bytes_written = written_text.bytesize

                row = self.row
                column = self.column

                text_rows, text_columns = bytes_written.divmod(width)

                row += text_rows

                columns_remaining = width - column
                if columns_remaining > text_columns
                  column += text_columns
                else
                  row += 1
                  column = text_columns - columns_remaining
                end

                if row >= height
                  final_row = height - 1

                  scroll_rows = row - final_row
                  self.rows_scrolled += scroll_rows

                  row = final_row
                end

                self.row = row
                self.column = column

                bytes_written
              end

              def write_newline
                if bottom_row?
                  if scroll_rows_remaining.zero?
                    return 0
                  end

                  self.rows_scrolled += 1
                else
                  self.row += 1
                end

                self.column = 0

                1
              end

              def capacity?
                if scroll_rows_remaining > 0
                  true
                else
                  not bottom_row?
                end
              end

              def capacity
                capacity = 0

                rows_remaining = height + scroll_rows_remaining - row - 1

                if rows_remaining > 0
                  capacity += (rows_remaining - 1) * width

                  final_row = width - column
                  capacity += final_row
                end

                capacity
              end

              def scroll_rows_remaining
                scroll_rows - rows_scrolled
              end

              def bottom_row?
                row == height - 1
              end
            end
          end
        end
      end
    end
  end
end
