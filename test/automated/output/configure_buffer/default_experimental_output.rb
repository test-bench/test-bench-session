require_relative '../../automated_init'

context "Output" do
  context "Configure Buffer" do
    context "Default Experimental Output" do
      original_env = ENV.to_h

      ENV.clear

      context "TEST_BENCH_EXPERIMENTAL_OUTPUT isn't set" do
        control_experimental_output = false

        experimental_output = Session::Output::Writer::Defaults.experimental_output

        context "Off" do
          comment experimental_output.inspect
          detail "Control: #{control_experimental_output.inspect}"

          test do
            assert(experimental_output == control_experimental_output)
          end
        end
      end

      context "TEST_BENCH_EXPERIMENTAL_OUTPUT is set" do
        ENV['TEST_BENCH_EXPERIMENTAL_OUTPUT'] = 'on'

        control_experimental_output = true

        experimental_output = Session::Output::Writer::Defaults.experimental_output

        context "On" do
          comment experimental_output.inspect
          detail "Control: #{control_experimental_output.inspect}"

          test do
            assert(experimental_output == control_experimental_output)
          end
        end
      end

    ensure
      ENV.replace(original_env)
    end
  end
end
