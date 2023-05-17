require_relative '../interactive_init'

clear_screen

puts <<~TEXT

Save and Restore Cursor
= = =
#{console_info}
TEXT

if not ENV.key?('LINES')
  lines = 3
  puts "LINES isn't set; default of #{lines} will be used"
else
  lines = ENV.fetch('LINES').to_i
end

puts <<~TEXT
Lines: #{lines}

TEXT

$stdout.flush

buffer = Session::Output::Writer::Buffer::Interactive.new
buffer.device = TestBench::Output::Writer::Defaults.device
buffer.save_cursor

puts "\e[1mBuffering (will be overwritten)\e[0m"

(1..lines).each do |line|
  puts "  Line ##{line}\n"
end

buffer.stderr_buffer << "Some text written to standard error\n"
buffer.stderr_buffer << "Some other text written to standard error\n"

sleep 1

buffer.restore_cursor

puts "\e[1mFinished buffering\e[0m\e[0K"

(1..lines).each do |line|
  puts "  Line ##{line}\e[0K"
end

puts <<~TEXT

(done)
- - -

TEXT
