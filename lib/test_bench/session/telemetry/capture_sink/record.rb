module TestBench
  class Session
    module Telemetry
      class CaptureSink
        Record = Struct.new(:event, :path) do
          def path_segments_match?(*segments)
            if segments.empty?
              true
            else
              path.match?(*segments)
            end
          end
          alias :path_segments? :path_segments_match?
        end
      end
    end
  end
end
