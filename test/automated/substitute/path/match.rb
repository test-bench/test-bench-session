require_relative '../../automated_init'

context "Substitute" do
  context "Path" do
    context "Match Predicate" do
      control_segments = [
        'segment-1',
        'segment-2',
        'segment-3'
      ]

      path = Controls::Substitute::Path.example(control_segments)

      context "Match" do
        context "Exact Match" do
          segments = control_segments

          comment segments.join(', ')

          matches = path.match?(*segments)

          test do
            assert(matches)
          end
        end

        context "Inner Segment Matches" do
          segments = [
            control_segments[1],
            control_segments[2]
          ]

          comment segments.join(', ')

          matches = path.match?(*segments)

          test do
            assert(matches)
          end
        end

        context "Only Final Segment Matches" do
          segment = control_segments[-1]

          comment segment.inspect

          matches = path.match?(segment)

          test do
            assert(matches)
          end
        end
      end

      context "No Match" do
        other_segment = Controls::Random.string

        context "Incorrect Segment" do
          segments = [
            control_segments[0],
            other_segment,
            control_segments[2]
          ]

          comment segments.join(', ')

          matches = path.match?(*segments)

          test do
            refute(matches)
          end
        end

        context "Incorrect Final Segment" do
          segments = [
            control_segments[0],
            control_segments[1],
            other_segment
          ]

          comment other_segment

          matches = path.match?(other_segment)

          test do
            refute(matches)
          end
        end

        context "Segments Out Of Order" do
          segments = [
            control_segments[1],
            control_segments[0],
            control_segments[2]
          ]

          comment segments.join(', ')

          matches = path.match?(*segments)

          test do
            refute(matches)
          end
        end

        context "Final Segment Missing" do
          segments = [
            control_segments[0],
            control_segments[1]
          ]

          comment segments.join(', ')

          matches = path.match?(*segments)

          test do
            refute(matches)
          end
        end

        context "Final Segment Duplicated" do
          segments = [
            control_segments[0],
            control_segments[1],
            control_segments[2],
            control_segments[2]
          ]

          comment segments.join(', ')

          matches = path.match?(*segments)

          test do
            refute(matches)
          end
        end
      end
    end
  end
end
