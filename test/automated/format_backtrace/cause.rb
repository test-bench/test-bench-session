require_relative '../automated_init'

context "Format Backtrace" do
  context "Cause" do
    exception = Controls::Exception::Cause::Example
    detail "Raw exception:", exception.full_message

    omit_pattern = Controls::Backtrace.pattern
    comment "Omit pattern: #{omit_pattern.inspect}"

    format_backtrace = Session::Exception::FormatBacktrace.new

    format_backtrace.omit_patterns = [
      omit_pattern,
      "non-matching-pattern-*"
    ]

    format_backtrace.(exception)

    context "Backtrace" do
      cause_backtrace = exception.cause.backtrace
      control_cause_backtrace = Controls::Backtrace::Cause.example

      comment "#{cause_backtrace.join("\n")}\n"
      detail "Control:", "#{control_cause_backtrace.join("\n")}\n"

      test do
        assert(cause_backtrace == control_cause_backtrace)
      end
    end
  end
end
