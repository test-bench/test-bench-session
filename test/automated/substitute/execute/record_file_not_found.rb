require_relative '../../automated_init'

context "Substitute" do
  context "Execute" do
    context "Record File Not Found" do
      file_path = Controls::Path::File.example

      substitute = Substitute.build

      substitute.record_file_not_found!

      substitute.execute(file_path)

      context "Isolate" do
        isolate = substitute.isolate

        test "Not executed" do
          refute(isolate.executed?(file_path))
        end
      end
    end
  end
end
