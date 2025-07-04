require_relative '../../automated_init'

context "Substitute" do
  context "Execute" do
    file_path = Controls::Path::File.example

    substitute = Substitute.build

    substitute.execute(file_path)

    context "Isolate" do
      isolate = substitute.isolate

      test "Executed" do
        assert(isolate.executed?(file_path))
      end
    end
  end
end
