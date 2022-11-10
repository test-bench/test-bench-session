require_relative '../../automated_init'

context "Session" do
  context "Assert" do
    context "Non-Boolean Value" do
      path = Controls::Failure::Path.example
      line_number = Controls::Failure::LineNumber.example

      context "An Object" do
        session = Session.new

        result = Object.new

        begin
          session.assert(result, path, line_number)
        rescue TypeError => type_error
        end

        test "Type error" do
          refute(type_error.nil?)
        end

        test "Assertion not recorded" do
          refute(session.asserted?)
        end
      end

      context "Nil" do
        session = Session.new

        result = nil

        begin
          session.assert(result, path, line_number)
        rescue TypeError => type_error
        end

        test "Type error" do
          refute(type_error.nil?)
        end

        test "Assertion not recorded" do
          refute(session.asserted?)
        end
      end
    end
  end
end
