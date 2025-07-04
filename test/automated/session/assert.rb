require_relative '../automated_init'

context "Session" do
  context "Assert" do
    original_assertion_sequence = Controls::Sequence.example

    failure_message = "Some failure message"

    context "True" do
      session = Session.new

      session.assertion_sequence = original_assertion_sequence

      test do
        refute_raises(Failure) do
          session.assert(true, failure_message)
        end
      end

      context "Assertion Sequence" do
        assertion_sequence = session.assertion_sequence

        control_assertion_sequence = original_assertion_sequence + 1

        comment "Before: #{original_assertion_sequence.inspect}"
        comment "After: #{assertion_sequence.inspect}"
        detail "Control: #{control_assertion_sequence.inspect}"

        test "Incremented" do
          assert(assertion_sequence == control_assertion_sequence)
        end
      end
    end

    context "False" do
      session = Session.new

      session.assertion_sequence = original_assertion_sequence

      test! do
        assert_raises(Failure, failure_message) do
          session.assert(false, failure_message)
        end
      end

      context "Assertion Sequence" do
        assertion_sequence = session.assertion_sequence

        control_assertion_sequence = original_assertion_sequence + 1

        comment "Before: #{original_assertion_sequence.inspect}"
        comment "After: #{assertion_sequence.inspect}"
        detail "Control: #{control_assertion_sequence.inspect}"

        test "Incremented" do
          assert(assertion_sequence == control_assertion_sequence)
        end
      end
    end
  end
end
