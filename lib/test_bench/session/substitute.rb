module TestBench
  class Session
    module Substitute
      def self.build
        Session.build
      end

      class Session < Session
        attr_accessor :result

        def self.build
          instance = new

          telemetry = instance.telemetry
          Telemetry::CaptureSink.configure(telemetry, attr_name: :sink)

          telemetry.register(telemetry.sink)

          instance
        end

        def file(path)
          telemetry.record(Events::FileStarted.new(path))

          telemetry.record(Events::FileFinished.new(path, result))

          result
        end
      end
    end
  end
end
