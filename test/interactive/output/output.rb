require_relative '../interactive_init'

ENV['TEST_BENCH_EXPERIMENTAL_OUTPUT'] ||= 'on'

telemetry = Telemetry.new

Session::Output.register(telemetry)

clear_screen

result = ENV.fetch('RESULT', 'pass') == 'pass'
comment_sequence_length = ENV.fetch('SEQUENCE', 1).to_i

puts <<~TEXT
Output
= = =
Result: #{result ? 'pass' : 'fail'}

#{console_info}
TEXT

telemetry.record(Controls::Events::ContextStarted.example)

comment_sequence_length.times do |index|
  telemetry.record(Controls::Events::Commented.example(text: "Some comment ##{index + 1}"))
  telemetry.record(Controls::Events::Detailed.example(text: "Some detail ##{index + 1}"))
end

telemetry.record(Controls::Events::TestStarted.example)
telemetry.record(Controls::Events::TestFinished.example(result: true))

telemetry.record(Controls::Events::TestStarted.example(title: "Some other test"))

sleep 1

if !result
  telemetry.record(Controls::Events::Failed.example)
end

telemetry.record(Controls::Events::TestFinished.example(result:, title: "Some other test"))

telemetry.record(Controls::Events::ContextFinished.example(result:))

puts <<~TEXT
- - -
(done)

TEXT
