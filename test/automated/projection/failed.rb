require_relative '../automated_init'

context "Projection" do
  context "Apply Failed Event" do
    failed = Controls::Events::Failed.example

    session = Session.new
    refute(session.failed?)

    projection = Session::Projection.new(session)

    projection.(failed)

    test "Session has failed" do
      assert(session.failed?)
    end
  end
end
