module TestBench
  class Session
    Failure = Class.new(RuntimeError)
    Abort = Class.new(Failure)

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

    def skip_sequence
      @skip_sequence ||= 0
    end
    attr_writer :skip_sequence

    def comment(text, quote, heading=nil)
      text = text&.to_str

      record_event(Events::Commented.new(text, quote, heading))
    end

    def context!(...)
      if context(...) == false
        message = Session.abort_message
        raise Abort, message
      end
    end

    def context(title=nil, &block)
      title = title&.to_str

      if block.nil?
        record_skip
        record_event(Events::ContextSkipped.new(title))
        return
      end

      original_failure_sequence = failure_sequence

      record_event(Events::ContextStarted.new(title))

      begin
        block.()

      rescue Failure

      ensure
        result = !failed?(original_failure_sequence)

        record_event(Events::ContextFinished.new(title, result))
      end

      result
    end

    def test!(...)
      if test(...) == false
        message = Session.abort_message
        raise Abort, message
      end
    end

    def test(title=nil, &block)
      title = title&.to_str

      if block.nil?
        record_skip
        record_event(Events::TestSkipped.new(title))
        return
      end

      original_failure_sequence = failure_sequence
      original_assertion_sequence = assertion_sequence

      record_event(Events::TestStarted.new(title))

      begin
        block.()

        result = !failed?(original_failure_sequence)

        if result
          if not asserted?(original_assertion_sequence)
            failure_message = Session.no_assertion_message
            fail(failure_message)
          end
        end

      rescue Failure
        result = false

      ensure
        record_event(Events::TestFinished.new(title, result))
      end

      result
    end

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

    def skipped?
      skip_sequence != 0
    end

    def record_skip
      self.skip_sequence += 1
    end

    def self.default_failure_message
      'Failed'
    end

    def self.assertion_failure_message
      "Assertion failed"
    end

    def self.abort_message
      "Abort"
    end

    def self.no_assertion_message
      "Test didn't perform an assertion"
    end
  end
end
