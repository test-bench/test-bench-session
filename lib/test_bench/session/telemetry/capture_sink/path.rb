module TestBench
  class Session
    module Telemetry
      class CaptureSink
        class Path
          def segments
            @segments ||= []
          end
          attr_writer :segments

          def push_segment(segment)
            segments << segment
          end
          alias :push :push_segment
          alias :<< :push

          def pop_segment(compare_segment=nil)
            segments.pop
          end
          alias :pop :pop_segment
        end
      end
    end
  end
end
