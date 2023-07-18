module TestBench
  class Session
    class Projection
      include Telemetry::Sink::Projection
      include Events

      receiver_name :session

      apply Failed do
        session.record_failure
      end
    end
  end
end
