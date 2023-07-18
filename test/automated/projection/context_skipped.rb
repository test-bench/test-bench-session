require_relative '../automated_init'

context "Projection" do
  context "Apply Context Skipped Event" do
    context_skipped = Controls::Events::ContextSkipped.example

    session = Session.new
    refute(session.skipped?)

    projection = Session::Projection.new(session)

    projection.(context_skipped)

    test "Session has a skipped test" do
      assert(session.skipped?)
    end
  end
end
