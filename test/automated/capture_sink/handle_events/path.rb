require_relative '../../automated_init'

context "Capture Sink" do
  context "Handle Events" do
    context "Path" do
      untested_event_types = Session::Events.each_type.to_a

      context "Appends Segment" do
        control_path_segments = ['some-segment', 'some-other-segment']

        [
          Controls::Events::TestStarted.example,
          Controls::Events::ContextStarted.example
        ].each do |event|
          event_type = event.event_type

          untested_event_types.delete(event_type)

          context "#{event_type}" do
            telemetry_sink = Session::Telemetry::CaptureSink.new

            title = event.title
            comment "Test Title: #{title}"

            control_path = Controls::CaptureSink::Path.example(control_path_segments)
            telemetry_sink.path = control_path

            record = telemetry_sink.(event)

            context "Record's Path" do
              path_segments = record.path.segments

              comment "Segments: #{path_segments.inspect}"
              detail "Original Path Segments: #{control_path_segments.inspect}"

              appended = path_segments == [*control_path_segments, title]

              test "Test title is appended" do
                assert(appended)
              end
            end

            context "Next Record's Path" do
              next_path_segments = telemetry_sink.path.segments

              comment "Segments: #{next_path_segments.inspect}"
              detail "Original Path Segments: #{control_path_segments.inspect}"

              appended = next_path_segments == [*control_path_segments, title]

              test "Test title is appended" do
                assert(appended)
              end
            end
          end
        end

        [
          Controls::Events::Commented.example,
          Controls::Events::Detailed.example
        ].each do |event|
          event_type = event.event_type

          untested_event_types.delete(event_type)

          context "#{event_type}" do
            telemetry_sink = Session::Telemetry::CaptureSink.new

            event_text = event.text
            comment "Comment: #{event_text}"

            control_path = Controls::CaptureSink::Path.example(control_path_segments)
            telemetry_sink.path = control_path

            record = telemetry_sink.(event)

            context "Record's Path" do
              path_segments = record.path.segments

              comment "Segments: #{path_segments.inspect}"
              detail "Original Path Segments: #{control_path_segments.inspect}"

              appended = path_segments == [*control_path_segments, event_text]

              test "Comment is appended" do
                assert(appended)
              end
            end

            context "Next Record's Path" do
              next_path_segments = telemetry_sink.path.segments

              comment "Segments: #{next_path_segments.inspect}"
              detail "Original Path Segments: #{control_path_segments.inspect}"

              not_appended = next_path_segments == control_path_segments

              test "Test title isn't appended" do
                assert(not_appended)
              end
            end
          end
        end
      end

      context "Pops Segment" do
        [
          Controls::Events::TestFinished.example,
          Controls::Events::ContextFinished.example
        ].each do |event|
          event_type = event.event_type

          untested_event_types.delete(event_type)

          context "#{event_type}" do
            telemetry_sink = Session::Telemetry::CaptureSink.new

            title = event.title
            comment "Test Title: #{title}"

            control_path_segments = ['some-segment', title]

            control_path = Controls::CaptureSink::Path.example(control_path_segments)
            telemetry_sink.path = control_path

            record = telemetry_sink.(event)

            context "Record's Path" do
              path_segments = record.path.segments

              comment "Segments: #{path_segments.inspect}"
              detail "Original Path Segments: #{control_path_segments.inspect}"

              title_included = path_segments == control_path_segments

              test "Title is included" do
                assert(title_included)
              end
            end

            context "Next Record's Path" do
              next_path_segments = telemetry_sink.path.segments

              comment "Segments: #{next_path_segments.inspect}"
              detail "Original Path Segments: #{control_path_segments.inspect}"

              popped = next_path_segments == control_path_segments[0...-1]

              test "Final segment is popped" do
                assert(popped)
              end
            end
          end
        end
      end

      context "Doesn't Append Segment" do
        control_path_segments = ['some-segment', 'some-other-segment']

        Controls::Events.each_example do |event|
          event_type = event.event_type
          if not untested_event_types.include?(event_type)
            next
          end

          context "#{event_type}" do
            telemetry_sink = Session::Telemetry::CaptureSink.new

            control_path = Controls::CaptureSink::Path.example(control_path_segments)
            telemetry_sink.path = control_path

            record = telemetry_sink.(event)

            context "Record's Path" do
              path_segments = record.path.segments

              comment "Segments: #{path_segments.inspect}"
              detail "Original Path Segments: #{control_path_segments.inspect}"

              not_appended = path_segments == control_path_segments

              test "Not appended" do
                assert(not_appended)
              end
            end

            context "Next Record's Path" do
              next_path_segments = telemetry_sink.path.segments

              comment "Segments: #{next_path_segments.inspect}"
              detail "Original Path Segments: #{control_path_segments.inspect}"

              not_appended = next_path_segments == control_path_segments

              test "Test title isn't appended" do
                assert(not_appended)
              end
            end
          end
        end
      end
    end
  end
end
