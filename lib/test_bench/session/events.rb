module TestBench
  class Session
    module Events
      Failed = TestBench::Telemetry::Event.define(:message, :path, :line_number)

      TestStarted = TestBench::Telemetry::Event.define(:title)
      TestFinished = TestBench::Telemetry::Event.define(:title, :result)
      TestSkipped = TestBench::Telemetry::Event.define(:title)

      ContextStarted = TestBench::Telemetry::Event.define(:title)
      ContextFinished = TestBench::Telemetry::Event.define(:title, :result)
      ContextSkipped = TestBench::Telemetry::Event.define(:title)

      Commented = TestBench::Telemetry::Event.define(:text)
    end
  end
end
