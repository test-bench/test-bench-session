module TestBench
  class Session
    class Output
      class Writer < TestBench::Output::Writer
        def alternate_device
          @alternate_device ||= TestBench::Output::Device::Substitute.build
        end
        attr_writer :alternate_device

        def indentation_depth
          @indentation_depth ||= 0
        end
        attr_writer :indentation_depth

        def indent
          indentation = '  ' * indentation_depth

          print(indentation)
        end

        def flush
          buffer.flush(device, alternate_device)
        end

        def write!(data)
          device.write(data)
          alternate_device.write(data)
        end

        def increase_indentation
          self.indentation_depth += 1
        end
        alias :indent! :increase_indentation

        def decrease_indentation
          self.indentation_depth -= 1
        end
        alias :deindent! :decrease_indentation
      end
    end
  end
end
