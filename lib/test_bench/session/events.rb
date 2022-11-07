module TestBench
  class Session
    module Events
      Failed = TestBench::Telemetry::Event.define(:message, :path, :line_number)
    end
  end
end
