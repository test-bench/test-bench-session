require_relative '../automated_init'

context "Format Backtrace" do
  context "Origin Matches" do
    exception = Controls::Exception::Example
    detail "Raw exception:", exception.full_message

    origin_frame = exception.backtrace.first
    omit_pattern, _ = origin_frame.split(':', 2)
    comment "Omit pattern: #{omit_pattern.inspect}"

    format_backtrace = Session::Exception::FormatBacktrace.new
    format_backtrace.omit_patterns << omit_pattern

    location = format_backtrace.(exception)

    context "Backtrace" do
      backtrace = exception.backtrace

      comment "#{backtrace.join("\n")}\n"

      test "Origin's frame isn't omitted" do
        assert(backtrace.first == origin_frame)
      end
    end

    context "Location" do
      control_location = exception.backtrace_locations[1]
      control_location = "#{control_location.path}:#{control_location.lineno}"

      comment location.inspect
      detail "Control: #{control_location.inspect}"

      test "First non-omitted frame" do
        assert(location == control_location)
      end
    end
  end
end
