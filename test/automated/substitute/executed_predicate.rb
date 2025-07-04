require_relative '../automated_init'

context "Substitute" do
  context "Executed Predicate" do
    session = Substitute.build

    control_file_path = Controls::Path::File.example

    session.execute(control_file_path)

    context "Affirmative" do
      context "Isolate Executed Given File" do
        file_path = control_file_path

        executed = session.executed?(file_path)

        test do
          assert(executed)
        end
      end
    end

    context "Negative" do
      context "Isolate Didn't Execute Given File" do
        other_file_path = Controls::Path::File.other_example

        executed = session.executed?(other_file_path)

        test do
          refute(executed)
        end
      end
    end
  end
end
