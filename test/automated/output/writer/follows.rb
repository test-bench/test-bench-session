require_relative '../../automated_init'

context "Output" do
  context "Writer" do
    context "Follows Predicate" do
      other_writer = Session::Output::Writer.new

      peer_writer = Session::Output::Writer.new
      peer_writer.peer = other_writer

      sequence = 11
      other_writer.sequence = 11

      context "Follows" do
        writer = Session::Output::Writer.new

        writer.device = other_writer
        writer.alternate_device = peer_writer
        writer.sequence = other_writer.sequence + 1

        context do
          follows = writer.follows?(other_writer)

          test do
            assert(follows)
          end
        end

        context "Follows Writer's Peer" do
          follows = writer.follows?(peer_writer)

          test do
            assert(follows)
          end
        end
      end

      context "Doesn't Follow" do
        context "Device Isn't Other Writer" do
          writer = Session::Output::Writer.new

          writer.alternate_device = peer_writer
          writer.sequence = other_writer.sequence + 1

          follows = writer.follows?(other_writer)

          test do
            refute(follows)
          end
        end

        context "Sequence Is Less Than Other Writer's" do
          writer = Session::Output::Writer.new

          writer.device = other_writer
          writer.alternate_device = peer_writer
          writer.sequence = other_writer.sequence - 1

          follows = writer.follows?(other_writer)

          test do
            refute(follows)
          end
        end
      end
    end
  end
end
