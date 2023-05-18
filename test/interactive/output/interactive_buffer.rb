require_relative '../interactive_init'

clear_screen

lines = ENV.fetch('LINES', console_rows + 1).to_i

puts <<~TEXT

Interactive Buffer
= = =
#{console_info}
Lines: #{lines}#{' (default, set via e.g. LINES=11)' if not ENV.key?('LINES')}

TEXT
$stdout.flush

buffer = Session::Output::Writer::Buffer::Interactive.new
buffer.device = TestBench::Output::Writer::Defaults.device

buffer.receive("\e[1m")
buffer.receive("Buffering")
buffer.receive("\e[22m")
buffer.receive("\n")

styled_text = String.new
"Every character contains an escape sequence".each_char do |char|
  styled_text << "\e[1;3;4;30;47m#{char}\e[49;39;24;23;22m"
end

(1..lines).each do |line|
  buffer.receive("  Line ##{line}\n")

  STDERR.puts "Standard error message ##{line} (#{styled_text})"
  buffer.update_stderr_buffer
end

sleep 1

buffer.flush

puts "\e[1mFinished buffering\e[22m\e[0K"

(1..lines).each do |line|
  puts "  Line ##{line}\e[0K"
end

puts <<~TEXT

(done)
- - -

TEXT
