module TestBench
  class Session
    module Events
      Failed = TestBench::Telemetry::Event.define(:message)

      TestStarted = TestBench::Telemetry::Event.define(:title)
      TestFinished = TestBench::Telemetry::Event.define(:title, :result)
      TestSkipped = TestBench::Telemetry::Event.define(:title)

      ContextStarted = TestBench::Telemetry::Event.define(:title)
      ContextFinished = TestBench::Telemetry::Event.define(:title, :result)
      ContextSkipped = TestBench::Telemetry::Event.define(:title)

      Commented = TestBench::Telemetry::Event.define(:text, :quote, :heading)
      Detailed = TestBench::Telemetry::Event.define(:text, :quote, :heading)

      FixtureStarted = TestBench::Telemetry::Event.define(:name)
      FixtureFinished = TestBench::Telemetry::Event.define(:name, :result)

      FileStarted = TestBench::Telemetry::Event.define(:path)
      FileFinished = TestBench::Telemetry::Event.define(:path, :result)
    end
  end
end
