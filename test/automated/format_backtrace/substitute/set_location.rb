require_relative '../../automated_init'

context "Format Backtrace" do
  context "Substitute" do
    context "Set Location" do
      substitute = Session::Exception::FormatBacktrace::Substitute.build

      control_location = Controls::Backtrace::Location.example

      substitute.set_location(control_location)

      location = substitute.(Controls::Exception::Example)

      test "Result location is the set location" do
        assert(location == control_location)
      end
    end
  end
end
