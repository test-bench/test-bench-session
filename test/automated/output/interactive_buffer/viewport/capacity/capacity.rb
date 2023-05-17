require_relative '../../../../automated_init'

context "Output" do
  context "Interactive Buffer" do
    context "Viewport" do
      context "Capacity" do
        width, height = 3, 3

        [
          [0, 0, 6],
          [0, 1, 5],
          [0, 2, 4],
          [1, 0, 3],
          [1, 1, 2],
          [1, 2, 1],
          [2, 0, 0],
          [2, 1, 0],
          [2, 2, 0]
        ].each do |row, column, control_capacity|
          title = String.new

          if row == 0
            title << 'Top'
          elsif row == 1
            title << 'Middle'
          elsif row == 2
            title << 'Bottom'
          end

          if column == 0
            title << ' Left'
          elsif column == 1
            if row != 1
              title << ' Middle'
            end
          elsif column == 2
            title << ' Right'
          end

          title << ' Cursor'

          context "#{title}" do
            viewport = Session::Output::Writer::Buffer::Interactive::Viewport.build(width, height, row, column)

            rows = ["···\n", "···\n", "···\e[22m\n"]

            cursor = "\e[22;1m◉\e[22m"
            if row == 2
              cursor << "\e[2m"
            end
            rows[row][column] = cursor
            rows.last.insert(0, "\e[2m")

            detail "Console:", rows.join

            context "Capacity" do
              capacity = viewport.capacity

              comment capacity.inspect
              detail "Control Capacity: #{control_capacity.inspect}"

              test do
                assert(capacity == control_capacity)
              end
            end
          end
        end
      end
    end
  end
end
