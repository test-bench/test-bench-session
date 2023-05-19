require_relative '../interactive_init'

clear_screen

lines = ENV.fetch('LINES', console_rows + 1).to_i

print <<~TEXT.chomp

Get Viewport
= = =
#{console_info}

012345678
        |
        v
Cursor:\u0020
TEXT

$stdout.flush

viewport = Session::Output::Writer::Buffer::Interactive::Viewport.get

puts "(here)"

puts <<~TEXT

Dimensions: #{viewport.width}x#{viewport.height}
Cursor Row: #{viewport.row}
Cursor Column: #{viewport.column}
Scroll Rows Remaining: #{viewport.scroll_rows_remaining} (should be identical to row)

TEXT

puts <<~TEXT
(done)
- - -

TEXT
