require_relative '../automated_init'

context "Format Backtrace" do
  context "Styling" do
    exception = Controls::Exception::Example
    detail "Raw exception:", exception.full_message

    omit_pattern = Controls::Backtrace.pattern
    comment "Omit pattern: #{omit_pattern.inspect}"

    format_backtrace = Session::Exception::FormatBacktrace.new
    format_backtrace.omit_patterns << omit_pattern

    format_backtrace.styling = true

    format_backtrace.(exception)

    context "Backtrace" do
      backtrace = exception.backtrace
      control_backtrace = Controls::Backtrace::Styling.example

      comment "#{backtrace.join("\n")}\n"
      detail "Control:", "#{control_backtrace.join("\n")}\n"

      test do
        assert(backtrace == control_backtrace)
      end
    end
  end
end
