module TestBench
  class Session
    class Output
      def mode
        @mode ||= Mode.initial
      end
      attr_writer :mode

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
