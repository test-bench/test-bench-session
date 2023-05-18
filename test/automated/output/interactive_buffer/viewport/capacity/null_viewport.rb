require_relative '../../../../automated_init'

context "Output" do
  context "Interactive Buffer" do
    context "Viewport" do
      context "Capacity" do
        context "Null Viewport" do
          viewport = Session::Output::Writer::Buffer::Interactive::Viewport.null

          test "No capacity" do
            assert(viewport.capacity == 0)
          end
        end
      end
    end
  end
end
