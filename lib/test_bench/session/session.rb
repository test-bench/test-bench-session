module TestBench
  class Session
    Failure = Class.new(RuntimeError)

    def telemetry
      @telemetry ||= TestBench::Telemetry::Substitute.build
    end
    attr_writer :telemetry

    def failure_sequence
      @failure_sequence ||= 0
    end
    attr_writer :failure_sequence

    def assertion_sequence
      @assertion_sequence ||= 0
    end
    attr_writer :assertion_sequence

    def assert(result, path, line_number)
      failure_message = Session.assertion_failure_message

      if result != true && result != false
        raise TypeError, "Value #{result.inspect} isn't a boolean"
      end

      record_assertion

      if result == false
        fail(failure_message, path, line_number)
      end
    end

    def fail(message, path, line_number)
      record_failure

      telemetry.record(Events::Failed.new(message, path, line_number))

      raise Failure, message
    end

    def asserted?(compare_sequence=nil)
      compare_sequence ||= 0

      compare_sequence != assertion_sequence
    end

    def record_assertion
      self.assertion_sequence += 1
    end

    def failed?(compare_sequence=nil)
      compare_sequence ||= 0

      compare_sequence != failure_sequence
    end

    def record_failure
      self.failure_sequence += 1
    end

    def self.assertion_failure_message
      "Assertion failed"
    end
  end
end
