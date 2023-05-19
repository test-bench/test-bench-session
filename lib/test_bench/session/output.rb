module TestBench
  class Session
    class Output
      def pending_writer
        @writer ||= Writer::Substitute.build
      end
      attr_writer :pending_writer

      def passing_writer
        @passing_writer ||= Writer::Substitute.build
      end
      attr_writer :passing_writer

      def failing_writer
        @failing_writer ||= Writer::Substitute.build
      end
      attr_writer :failing_writer

      def mode
        @mode ||= Mode.initial
      end
      attr_writer :mode

      def branch_count
        @branch_count ||= 0
      end
      attr_writer :branch_count

      def current_writer
        if initial? || pending?
          pending_writer
        elsif passing?
          passing_writer
        elsif failing?
          failing_writer
        end
      end
      alias :writer :current_writer

      def branch
        if branch_count.zero?
          self.mode = Mode.pending

          pending_writer.sync = false

          parent_writer = pending_writer
        else
          parent_writer = passing_writer
        end

        self.branch_count += 1

        self.passing_writer, self.failing_writer = parent_writer.branch
      end

      def merge(result)
        self.branch_count -= 1

        if not branched?
          pending_writer.sync = true

          self.mode = Mode.initial
        end

        if result
          writer = passing_writer
        else
          writer = failing_writer
        end

        writer.flush

        self.passing_writer = writer.device
        self.failing_writer = writer.alternate_device
      end

      def branched?
        branch_count > 0
      end

      def initial?
        mode == Mode.initial
      end

      def pending?
        mode == Mode.pending
      end

      def passing?
        mode == Mode.passing
      end

      def failing?
        mode == Mode.failing
      end

      module Mode
        def self.initial = :initial
        def self.pending = :pending
        def self.passing = :passing
        def self.failing = :failing
      end
    end
  end
end
