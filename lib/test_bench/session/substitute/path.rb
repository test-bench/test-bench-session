module TestBench
  class Session
    module Substitute
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
      end
    end
  end
end
