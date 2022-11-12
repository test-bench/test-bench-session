module TestBench
  class Session
    module Handler
      def self.included(cls)
        cls.class_exec do
          include Telemetry::Sink::Handler
          include Events
        end
      end
    end
  end
end
