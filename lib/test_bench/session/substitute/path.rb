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

        def pop_segment(compare_segment=nil)
          segments.pop
        end
        alias :pop :pop_segment

        def copy(receiver)
          path = self.class.new

          segments.each do |segment|
            path << segment
          end

          receiver.path = path
          path
        end
      end
    end
  end
end
