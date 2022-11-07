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

    def assert(result)
      failure_message = Session.assertion_failure_message

      record_assertion

      if result == false
        fail(failure_message)
      end
    end

    def fail(message=nil)
      message ||= self.class.default_failure_message

      record_failure

      record_event(Events::Failed.new(message))

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

    def record_event(event)
      telemetry.record(event)
    end

    def record_failure
      self.failure_sequence += 1
    end

    def self.default_failure_message
      'Failed'
    end

    def self.assertion_failure_message
      "Assertion failed"
    end
  end
end
