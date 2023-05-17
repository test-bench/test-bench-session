module TestBench
  class Session
    class Output
      class Writer
        module Buffer
          class Interactive
            attr_accessor :viewport

            attr_accessor :raw_stderr

            attr_accessor :stderr_pipe

            def stderr_buffer
              @stderr_buffer ||= String.new
            end

            def device
              @device ||= TestBench::Output::Device::Substitute.build
            end
            attr_writer :device

            def save_cursor
              self.viewport = Viewport.get

              self.raw_stderr = STDERR.dup

              reader, writer = IO.pipe

              new_stderr = writer
              STDERR.reopen(new_stderr)

              stderr_buffer.clear

              self.stderr_pipe = reader

              device.write("\e[s")
            end

            def restore_cursor
              stderr_pipe.close

              device.write("\e[u")

              rows_scrolled = viewport.rows_scrolled

              if not rows_scrolled.zero?
                upward_movements = rows_scrolled
                device.write("\e[#{upward_movements}F")
              end

              stderr_buffer.each_line do |line|
                raw_stderr.write("\e[0K")
                raw_stderr.write(line)
              end

              STDERR.reopen(raw_stderr)
              self.raw_stderr = nil

              self.viewport = nil
            end
          end
        end
      end
    end
  end
end
