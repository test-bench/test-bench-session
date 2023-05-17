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
