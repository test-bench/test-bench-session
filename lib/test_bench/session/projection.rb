module TestBench
  class Session
    class Projection
      include Telemetry::Sink::Projection
      include Events

      receiver_name :session

      apply Failed do
        session.record_failure
      end

      apply TestSkipped do
        session.record_skip
      end

      apply ContextSkipped do
        session.record_skip
      end
    end
  end
end
