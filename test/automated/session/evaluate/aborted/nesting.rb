require_relative '../../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Aborted" do
      context "Nesting" do
        session = Session.new

        exception = Controls::Exception.example

        begin
          session.evaluate(Controls::Event::Pending.example) do
            session.evaluate(Controls::Event::Pending.example) do
              raise exception
            end
          end
        rescue Controls::Exception::SomeException
        end

        test "Only one aborted event is recorded" do
          assert(session.telemetry.one_event?(Events::Aborted))
        end
      end
    end
  end
end
