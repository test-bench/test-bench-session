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
  end
end
