require_relative '../automated_init'

context "Format Backtrace" do
  exception = Controls::Exception::NoBacktraceLocation.example
  detail "Raw exception:", exception.full_message

  format_backtrace = Session::Exception::FormatBacktrace.new

  test "Isn't an error" do
    refute_raises do
      format_backtrace.(exception)
    end
  end
end
