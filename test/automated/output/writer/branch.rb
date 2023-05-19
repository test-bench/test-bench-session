require_relative '../../automated_init'

context "Output" do
  context "Writer" do
    context "Branch" do
      writer = Session::Output::Writer.new

      assert(writer.sync)

      primary, alternate = writer.branch

      context "Primary" do
        test! do
          assert(primary.instance_of?(Session::Output::Writer))
        end

        test "Follows the original writer" do
          assert(primary.follows?(writer))
        end

        context "Peer" do
          peer = primary.peer

          test "Is the alternate writer" do
            assert(peer == alternate)
          end
        end
      end

      context "Alternate" do
        test! do
          assert(alternate.instance_of?(Session::Output::Writer))
        end

        test "Follows the original writer" do
          assert(alternate.follows?(writer))
        end

        context "No peer" do
          peer = alternate.peer

          test do
            assert(peer.nil?)
          end
        end
      end
    end
  end
end
