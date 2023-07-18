require_relative '../automated_init'

context "Projection" do
  context "Apply Test Skipped Event" do
    test_skipped = Controls::Events::TestSkipped.example

    session = Session.new
    refute(session.skipped?)

    projection = Session::Projection.new(session)

    projection.(test_skipped)

    test "Session has a skipped test" do
      assert(session.skipped?)
    end
  end
end
