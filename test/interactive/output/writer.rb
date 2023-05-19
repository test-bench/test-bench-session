require_relative '../interactive_init'

ENV['TEST_BENCH_EXPERIMENTAL_OUTPUT'] ||= 'on'

writer = Session::Output::Writer.build

clear_screen

result = ENV.fetch('RESULT', 'pass') == 'pass'
comment_sequence_length = ENV.fetch('SEQUENCE', 1).to_i

puts <<~TEXT
Output Writer
= = =
Result: #{result ? 'pass' : 'fail'}

#{console_info}
TEXT

comment_sequence = comment_sequence_length.times.flat_map do |index|
  [
    "Some comment ##{index + 1}",
    "Some detail ##{index + 1}"
  ]
end

writer.sync = false

primary, alternate = writer.branch

writer.style(:green).puts("Some Context")
primary.style(:green).puts("Some Context")
alternate.style(:green).puts("Some Context")

writer.indent!
primary.indent!
alternate.indent!

comment_sequence.each do |comment|
  alternate.puts(comment)

  if not comment.match?(/detail/)
    writer.puts(comment)
    primary.puts(comment)
  end
end

writer.style(:green).puts("Some test")
primary.style(:green).puts("Some test")
alternate.style(:green).puts("Some test")

writer.style(:faint).puts("Some other test")
primary.style(:green).puts("Some other test")
alternate.style(:red, :bold).puts("Some other test")

writer.indent!
primary.indent!
alternate.indent!

writer.puts("Some test comment")
primary.puts("Some test comment")
alternate.puts("Some test comment")
alternate.puts("Some test detail")

sleep 1

if not result
  [writer, primary, alternate].each do |w|
    w.indent.
      style(:bold, :red).
      print("Assertion failed").
      style(:reset_intensity).
      puts(" (path/to/some_test.rb:11)")
  end
end

writer.sync = true

if result
  primary.flush
else
  alternate.flush
end

puts <<~TEXT
- - -
(done)

TEXT
