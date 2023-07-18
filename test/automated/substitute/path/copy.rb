require_relative '../../automated_init'

context "Substitute" do
  context "Path" do
    context "Copy" do
      receiver = Struct.new(:path).new

      control_path = Controls::Substitute::Path.example
      control_path.copy(receiver)

      comment "Original Segments: #{control_path.segments.join(', ')}"

      context "Copied Path" do
        path = receiver.path

        comment "Copied Segments: #{path&.segments.inspect}"

        test "Equivalent to original path" do
          assert(path.segments == control_path.segments)
        end

        test "Copy of original path" do
          refute(path.equal?(control_path))
        end
      end
    end
  end
end
