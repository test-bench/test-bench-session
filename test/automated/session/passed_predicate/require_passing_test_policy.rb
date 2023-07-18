require_relative '../../automated_init'

context "Session" do
  context "Passed Predicated" do
    context "Require Passing Test Policy" do
      original_env = ENV.to_h

      ENV.clear

      context "TEST_BENCH_REQUIRE_PASSING_TEST isn't deactivated" do
        context "Assertions And No Skipped Tests" do
          session = Session.new

          session.record_assertion

          passed = session.passed?

          test "Passed" do
            assert(passed)
          end
        end

        context "No Assertions" do
          session = Session.new

          passed = session.passed?

          test "Not passed" do
            refute(passed)
          end
        end

        context "Skipped Tests" do
          session = Session.new

          session.record_skip

          passed = session.passed?

          test "Not passed" do
            refute(passed)
          end
        end
      end

      context "TEST_BENCH_REQUIRE_PASSING_TEST is deactivated" do
        ENV['TEST_BENCH_REQUIRE_PASSING_TEST'] = 'off'

        context "Assertions And No Skipped Tests" do
          session = Session.new

          session.record_assertion

          passed = session.passed?

          test "Passed" do
            assert(passed)
          end
        end

        context "No Assertions" do
          session = Session.new

          passed = session.passed?

          test "Passed" do
            assert(passed)
          end
        end

        context "Skipped Tests" do
          session = Session.new

          session.record_skip

          passed = session.passed?

          test "Passed" do
            assert(passed)
          end
        end
      end

    ensure
      ENV.replace(original_env)
    end
  end
end
