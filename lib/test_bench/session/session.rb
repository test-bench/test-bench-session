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

    def context!(...)
      if context(...) == false
        message = Session.abort_message
        raise Abort, message
      end
    end

    def context(title=nil, &block)
      if block.nil?
        telemetry.record(Events::ContextSkipped.new(title))
        return
      end

      original_failure_sequence = failure_sequence

      telemetry.record(Events::ContextStarted.new(title))

      begin
        block.()

      rescue Failure

      ensure
        result = !failed?(original_failure_sequence)

        telemetry.record(Events::ContextFinished.new(title, result))
      end

      result
    end

    def test!(...)
      if test(...) == false
        message = Session.abort_message
        raise Abort, message
      end
    end

    def test(path, line_number, title=nil, &block)
      if block.nil?
        telemetry.record(Events::TestSkipped.new(title))
        return
      end

      original_failure_sequence = failure_sequence
      original_assertion_sequence = assertion_sequence

      telemetry.record(Events::TestStarted.new(title))

      begin
        block.()

        result = !failed?(original_failure_sequence)

        if result
          if not asserted?(original_assertion_sequence)
            failure_message = Session.no_assertion_message
            fail(failure_message, path, line_number)
          end
        end

      rescue Failure
        result = false

      ensure
        telemetry.record(Events::TestFinished.new(title, result))
      end

      result
    end

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

    def skipped?
      skip_sequence != 0
    end

    def record_skip
      self.skip_sequence += 1
    end

    def self.assertion_failure_message
      "Assertion failed"
    end

    def self.no_assertion_message
      "Test didn't perform an assertion"
    end

    def self.abort_message
      "Abort"
    end
  end
end
