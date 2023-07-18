require_relative '../automated_init'

context "Projection" do
  context "Apply Test Finished Event" do
    context "Pass" do
      result = Controls::Result.pass
      test_finished = Controls::Events::TestFinished.example(result:)

      session = Session.new
      refute(session.passed?)

      projection = Session::Projection.new(session)

      projection.(test_finished)

      test "Passed" do
        assert(session.passed?)
      end
    end

    context "Failure" do
      result = Controls::Result.failure
      test_finished = Controls::Events::TestFinished.example(result:)

      session = Session.new
      refute(session.passed?)

      projection = Session::Projection.new(session)

      projection.(test_finished)

      test "Not passed" do
        refute(session.passed?)
      end
    end
  end
end
