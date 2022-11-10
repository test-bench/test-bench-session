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

          def block_match?(&block)
            if block.nil?
              true
            elsif block.(event.event_type, *event.values)
              true
            else
              false
            end
          end
          alias :block? :block_match?
        end
      end
    end
  end
end
