require_relative '../automated_init'

context "Format Backtrace" do
  exception = Controls::Exception::Example
  detail "Raw exception:", exception.full_message

  omit_pattern = Controls::Backtrace.pattern
  comment "Omit pattern: #{omit_pattern.inspect}"

  format_backtrace = Session::Exception::FormatBacktrace.new

  format_backtrace.omit_patterns = [
    omit_pattern,
    "non-matching-pattern-*"
  ]

  location = format_backtrace.(exception)

  context "Backtrace" do
    backtrace = exception.backtrace
    control_backtrace = Controls::Backtrace.example

    comment "#{backtrace.join("\n")}\n"
    detail "Control:", "#{control_backtrace.join("\n")}\n"

    test do
      assert(backtrace == control_backtrace)
    end
  end

  context "Location" do
    control_location = Controls::Backtrace.location

    comment location.inspect
    detail "Control: #{control_location.inspect}"

    test do
      assert(location == control_location)
    end
  end
end
