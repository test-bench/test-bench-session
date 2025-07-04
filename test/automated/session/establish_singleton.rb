require_relative '../automated_init'

context "Session" do
  context "Establish Singleton Session" do
    original_session = Session.instance
    comment "Original Session Singleton: #{original_session.inspect}"

    control_session = Session.new

    begin
      Session.establish(control_session)

      session = Session.instance
    ensure
      Session.establish(original_session)
    end

    comment "Singleton Session: #{session.inspect}"
    detail "Control Session: #{control_session.inspect}"

    test do
      assert(session == control_session)
    end
  end
end
