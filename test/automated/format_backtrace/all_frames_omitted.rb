require_relative '../automated_init'

context "Format Backtrace" do
  context "All Frames Omitted" do
    exception = Controls::Exception::Example
    detail "Raw exception:", exception.full_message

    omit_pattern = '*'
    comment "Omit pattern: #{omit_pattern.inspect}"

    origin_frame = exception.backtrace_locations.first
    comment "Origin frame: #{origin_frame.inspect}"

    format_backtrace = Session::Exception::FormatBacktrace.new
    format_backtrace.omit_patterns << omit_pattern

    location = format_backtrace.(exception)

    context "Backtrace" do
      backtrace = exception.backtrace

      comment "#{backtrace.join("\n")}\n"

      test "Only origin frame" do
        assert(backtrace == [origin_frame.to_s, "*omitted*"])
      end
    end

    context "Location" do
      control_location = "#{origin_frame.path}:#{origin_frame.lineno}"

      comment location.inspect
      detail "Control: #{control_location.inspect}"

      test "Origin frame" do
        assert(location == control_location)
      end
    end
  end
end
