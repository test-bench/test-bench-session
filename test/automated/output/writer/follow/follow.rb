require_relative '../../../automated_init'

context "Output" do
  context "Writer" do
    context "Follow" do
      original_writer = Session::Output::Writer.new
      original_writer.sync = true

      control_styling_policy = Controls::Output::Styling.random
      original_writer.styling_policy = control_styling_policy

      control_digest = Output::Digest.new
      data = Controls::Output::Data.example
      control_digest.update(data)
      original_writer.digest = control_digest

      control_sequence = 11
      original_writer.sequence = control_sequence

      control_column_sequence = 22
      original_writer.column_sequence = control_column_sequence

      control_indentation_depth = 1
      original_writer.indentation_depth = control_indentation_depth

      writer = Session::Output::Writer.follow(original_writer)

      test! do
        assert(writer.follows?(original_writer))
      end

      context "Styling Policy" do
        styling_policy = writer.styling_policy

        test "Copied" do
          assert(styling_policy == control_styling_policy)
        end
      end

      context "Digest" do
        digest = writer.digest

        test! do
          assert(digest.digest?(data))
        end

        test "Not copied" do
          refute(digest == control_digest)
        end
      end

      context "Sequence" do
        sequence = writer.sequence

        test "Copied" do
          assert(sequence == control_sequence)
        end
      end

      context "Column Sequence" do
        column_sequence = writer.column_sequence

        test "Copied" do
          assert(column_sequence == control_column_sequence)
        end
      end

      context "Indentation Depth" do
        indentation_depth = writer.indentation_depth

        test "Copied" do
          assert(indentation_depth == control_indentation_depth)
        end
      end

      context "Sync" do
        sync = writer.sync

        test "Buffered mode" do
          assert(sync == false)
        end
      end
    end
  end
end
