require_relative '../../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Aborted" do
      context "Backtrace" do
        session = Session.new

        exception = Controls::Exception::Example

        begin
          session.evaluate(Controls::Event::Pending.example) do
            raise exception
          end
        rescue Controls::Exception::SomeException
        end

        context "Formatted" do
          formatted = session.format_backtrace.formatted?(exception)

          test do
            assert(formatted)
          end
        end
      end
    end
  end
end
