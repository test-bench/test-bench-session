require_relative '../../automated_init'

context "Output" do
  context "Detail Predicate" do
    context "Default Policy" do
      original_env = ENV.to_h

      ENV.clear

      context "TEST_BENCH_DETAIL isn't set" do
        control_policy = Session::Output::Detail.default!

        output = Session::Output.new

        context "Detail Policy" do
          detail_policy = output.detail_policy

          comment detail_policy.inspect
          detail "Control: #{control_policy.inspect}"

          test do
            assert(detail_policy == control_policy)
          end
        end
      end

      context "TEST_BENCH_DETAIL is set" do
        control_policy = Controls::Output::Detail.random

        ENV['TEST_BENCH_DETAIL'] = control_policy.to_s

        output = Session::Output.new

        context "Detail Policy" do
          detail_policy = output.detail_policy

          comment detail_policy.inspect
          detail "Control: #{control_policy.inspect}"

          test do
            assert(detail_policy == control_policy)
          end
        end
      end

    ensure
      ENV.replace(original_env)
    end
  end
end
