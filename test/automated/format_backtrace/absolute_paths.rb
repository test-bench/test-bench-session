require_relative '../automated_init'

context "Format Backtrace" do
  context "Absolute Paths" do
    exception = Controls::Exception::AbsolutePaths::Example
    detail "Raw exception:", exception.full_message

    omit_pattern = Controls::Backtrace.pattern
    comment "Omit pattern: #{omit_pattern.inspect}"

    context "Local Path" do
      format_backtrace = Session::Exception::FormatBacktrace.new

      format_backtrace.apex_directory = Controls::Backtrace::AbsolutePaths::Local.apex_directory

      format_backtrace.omit_patterns << omit_pattern

      location = format_backtrace.(exception)

      context "Backtrace" do
        backtrace = exception.backtrace
        control_backtrace = Controls::Backtrace::AbsolutePaths::Local.example

        comment "#{backtrace.join("\n")}\n"
        detail "Control:", "#{control_backtrace.join("\n")}\n"

        test do
          assert(backtrace == control_backtrace)
        end
      end

      context "Location" do
        control_location = Controls::Backtrace::Location::AbsolutePath::Local.example

        comment location.inspect
        detail "Control: #{control_location.inspect}"

        test do
          assert(location == control_location)
        end
      end
    end

    context "Non-Local Path" do
      format_backtrace = Session::Exception::FormatBacktrace.new

      format_backtrace.omit_patterns << omit_pattern

      location = format_backtrace.(exception)

      context "Backtrace" do
        backtrace = exception.backtrace
        control_backtrace = Controls::Backtrace::AbsolutePaths.example

        comment "#{backtrace.join("\n")}\n"
        detail "Control:", "#{control_backtrace.join("\n")}\n"

        test do
          assert(backtrace == control_backtrace)
        end
      end

      context "Location" do
        control_location = Controls::Backtrace::Location::AbsolutePath.example

        comment location.inspect
        detail "Control: #{control_location.inspect}"

        test do
          assert(location == control_location)
        end
      end
    end
  end
end
