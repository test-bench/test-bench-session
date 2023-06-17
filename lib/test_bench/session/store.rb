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
    end
  end
end
