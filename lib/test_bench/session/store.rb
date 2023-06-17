module TestBench
  class Session
    class Store
      PutError = Class.new(RuntimeError)

      attr_accessor :put_session

      def put(session)
        if not put_session.nil?
          raise PutError, "Already put a session"
        end

        self.put_session = session
      end

      def put?(session=nil)
        if not session.nil?
          put_session == session
        else
          !put_session.nil?
        end
      end

      def reset(session=nil)
        self.put_session = session
      end

      def get
        put_session
      end

      def fetch
        self.put_session ||= new_session
      end

      def new_session
        Session.build do |telemetry|
          Output.register_telemetry(telemetry)
        end
      end
    end
  end
end
