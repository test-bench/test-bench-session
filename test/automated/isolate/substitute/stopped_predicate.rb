require_relative '../../automated_init'

context "Isolate Substitute" do
  context "Stopped Predicate" do
    context "Affirmative" do
      substitute = Isolate::Substitute.build

      substitute.stop

      test do
        assert(substitute.stopped?)
      end
    end

    context "Negative" do
      substitute = Isolate::Substitute.build

      test do
        refute(substitute.stopped?)
      end
    end
  end
end
