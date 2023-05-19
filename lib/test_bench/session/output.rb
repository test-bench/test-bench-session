module TestBench
  class Session
    class Output
      include TestBench::Output
      include Events

      def pending_writer
        @pending_writer ||= Writer::Substitute.build
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

      def detail_policy
        @detail_policy ||= Detail.default
      end
      alias :detail :detail_policy
      attr_writer :detail_policy

      handle Detailed do |detailed|
        if not detail?
          return
        end

        text = detailed.text
        quote = detailed.quote
        heading = detailed.heading

        comment(text, quote, heading)
      end

      def comment(text, quote, heading)
        if not heading.nil?
          writer.
            indent.
            style(:bold, :underline).
            puts(heading)

          if not writer.styling?
            writer.
              indent.
              puts('- - -')
          end
        end

        if text.empty?
          writer.
            indent.
            style(:faint, :italic).
            puts('(empty)')
          return
        end

        if not quote
          writer.
            indent.
            puts(text)
        else
          text.each_line(chomp: true) do |line|
            writer.
              indent.
              style(:faint).
              print('> ').
              style(:reset_intensity).
              puts(line)
          end
        end
      end

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

      def detail?
        Detail.detail?(detail_policy, mode)
      end

      module Mode
        def self.initial = :initial
        def self.pending = :pending
        def self.passing = :passing
        def self.failing = :failing
      end

      module Detail
        Error = Class.new(RuntimeError)

        def self.detail?(policy, mode)
          assure_detail(policy, mode)
        end

        def self.assure_detail(policy, mode=nil)
          mode ||= Mode.initial

          case policy
          when on
            true
          when off
            false
          when failure
            if mode == Mode.failing || mode == Mode.initial
              true
            else
              false
            end
          else
            raise Error, "Unknown detail policy #{policy.inspect}"
          end
        end

        def self.on = :on
        def self.off = :off
        def self.failure = :failure

        def self.default
          policy = ENV.fetch('TEST_BENCH_DETAIL') do
            return default!
          end

          policy.to_sym
        end

        def self.default!
          :failure
        end
      end
    end
  end
end
