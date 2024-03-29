require_relative '../../../automated_init'

context "Substitute Sink" do
  context "Receive Events" do
    context "Path" do
      untested_event_types = Session::Events.each_type.to_a

      context "Appends Segment" do
        control_path_segments = ['some-segment', 'some-other-segment']

        context "Pushes Segment" do
          [
            Controls::Events::TestStarted.example,
            Controls::Events::ContextStarted.example
          ].each do |event|
            event_type = event.event_type

            untested_event_types.delete(event_type)

            context "#{event_type}" do
              substitute_sink = Session::Substitute::Sink.new

              title = event.title
              comment "Test Title: #{title}"

              control_path = Controls::Substitute::Path.example(control_path_segments)
              substitute_sink.path = control_path

              event_data = Telemetry::Event::Export.(event)
              record = substitute_sink.receive(event_data)

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
                next_path_segments = substitute_sink.path.segments

                comment "Segments: #{next_path_segments.inspect}"
                detail "Original Path Segments: #{control_path_segments.inspect}"

                appended = next_path_segments == [*control_path_segments, title]

                test "Test title is appended" do
                  assert(appended)
                end
              end
            end
          end
        end

        context "Doesn't Push Segment" do
          [
            Controls::Events::Commented.example,
            Controls::Events::Detailed.example
          ].each do |event|
            event_type = event.event_type

            untested_event_types.delete(event_type)

            context "#{event_type}" do
              substitute_sink = Session::Substitute::Sink.new

              event_text = event.text
              comment "Comment: #{event_text}"

              control_path = Controls::Substitute::Path.example(control_path_segments)
              substitute_sink.path = control_path

              event_data = Telemetry::Event::Export.(event)
              record = substitute_sink.receive(event_data)

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
                next_path_segments = substitute_sink.path.segments

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

      context "Pops Segment" do
        [
          Controls::Events::TestFinished.example,
          Controls::Events::ContextFinished.example
        ].each do |event|
          event_type = event.event_type

          untested_event_types.delete(event_type)

          context "#{event_type}" do
            substitute_sink = Session::Substitute::Sink.new

            title = event.title
            comment "Test Title: #{title}"

            control_path_segments = ['some-segment', title]

            control_path = Controls::Substitute::Path.example(control_path_segments)
            substitute_sink.path = control_path

            event_data = Telemetry::Event::Export.(event)
            record = substitute_sink.receive(event_data)

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
              next_path_segments = substitute_sink.path.segments

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

        events = Controls::Events.examples.select do |event|
          event_type = event.event_type

          untested_event_types.include?(event_type)
        end

        events << Controls::Events::TestStarted::NoTitle.example
        events << Controls::Events::ContextStarted::NoTitle.example
        events << Controls::Events::TestFinished::NoTitle.example
        events << Controls::Events::ContextFinished::NoTitle.example

        events.each do |event|
          event_type = event.event_type

          context "#{event_type}" do
            substitute_sink = Session::Substitute::Sink.new

            control_path = Controls::Substitute::Path.example(control_path_segments)
            substitute_sink.path = control_path

            event_data = Telemetry::Event::Export.(event)
            record = substitute_sink.receive(event_data)

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
              next_path_segments = substitute_sink.path.segments

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
