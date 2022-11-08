module TestBench
  class Session
    module Events
      Failed = TestBench::Telemetry::Event.define(:message)

      TestStarted = TestBench::Telemetry::Event.define(:title)
      TestFinished = TestBench::Telemetry::Event.define(:title, :result)
      TestSkipped = TestBench::Telemetry::Event.define(:title)
    end
  end
end
