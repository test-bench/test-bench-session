module TestBench
  class Session
    module Events
      Failed = TestBench::Telemetry::Event.define(:message)
    end
  end
end
