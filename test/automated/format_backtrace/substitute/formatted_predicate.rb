require_relative '../../automated_init'

context "Format Backtrace" do
  context "Substitute" do
    context "Formatted Predicate" do
      control_exception = Controls::Exception::Example

      substitute = Session::Exception::FormatBacktrace::Substitute.build

      substitute.(control_exception)

      context "Formatted Predicate" do
        context "Affirmative" do
          context "Given Exception Was Formatted" do
            exception = control_exception

            test do
              assert(substitute.formatted?(exception))
            end
          end
        end

        context "Negative" do
          context "Other Exception Was Formatted" do
            other_exception = Controls::Exception::Other::Example

            test do
              refute(substitute.formatted?(other_exception))
            end
          end
        end
      end
    end
  end
end
