require_relative '../../../automated_init'

context "Output" do
  context "Interactive Buffer" do
    context "Viewport" do
      context "Capacity Predicate" do
        width, height = 3, 3

        context "Capacity" do
          context "Not Bottom Row" do
            row = 1
            column = 2

            viewport = Session::Output::Writer::Buffer::Interactive::Viewport.build(width, height, row, column)

            comment viewport.capacity.inspect

            test do
              assert(viewport.capacity?)
            end
          end

          context "Scroll Rows Remaining" do
            row = 2
            column = 2
            scroll_rows = 1

            viewport = Session::Output::Writer::Buffer::Interactive::Viewport.build(width, height, row, column, scroll_rows)

            comment viewport.capacity.inspect

            test do
              assert(viewport.capacity?)
            end
          end
        end

        context "No Capacity" do
          row = 2
          column = 1

          viewport = Session::Output::Writer::Buffer::Interactive::Viewport.build(width, height, row, column)

          comment viewport.capacity.inspect

          test do
            refute(viewport.capacity?)
          end
        end
      end
    end
  end
end
