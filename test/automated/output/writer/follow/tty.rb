require_relative '../../../automated_init'

context "Output" do
  context "Writer" do
    context "Follow" do
      context "TTY" do
        context "Original Writer is a TTY" do
          original_writer = Session::Output::Writer.new
          original_writer.tty = true

          writer = Session::Output::Writer.follow(original_writer)

          test do
            assert(writer.tty?)
          end
        end

        context "Original Writer isn't a TTY" do
          original_writer = Session::Output::Writer.new
          original_writer.tty = false

          writer = Session::Output::Writer.follow(original_writer)

          test do
            refute(writer.tty?)
          end
        end
      end
    end
  end
end
