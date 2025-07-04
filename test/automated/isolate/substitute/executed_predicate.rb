require_relative '../../automated_init'

context "Isolate Substitute" do
  context "Executed Predicate" do
    file_path = Controls::Path::File.example

    context "Affirmative" do
      substitute = Isolate::Substitute.build

      substitute.(file_path)

      test do
        assert(substitute.executed?(file_path))
      end
    end

    context "Negative" do
      context "No File Was Ran" do
        substitute = Isolate::Substitute.build

        test do
          refute(substitute.executed?(file_path))
        end
      end

      context "Other File Was Ran" do
        other_file_path = Controls::Path::File.other_example

        substitute = Isolate::Substitute.build

        substitute.(other_file_path)

        test do
          refute(substitute.executed?(file_path))
        end
      end
    end
  end
end
