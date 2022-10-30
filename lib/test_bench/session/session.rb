module TestBench
  class Session
    def failure_sequence
      @failure_sequence ||= 0
    end
    attr_writer :failure_sequence

    def failed?(compare_sequence=nil)
      compare_sequence ||= 0

      compare_sequence != failure_sequence
    end

    def record_failure
      self.failure_sequence += 1
    end
  end
end
