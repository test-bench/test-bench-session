module TestBench
  class Session
    class Output
      class Writer < TestBench::Output::Writer
        def indentation_depth
          @indentation_depth ||= 0
        end
        attr_writer :indentation_depth

        def indent
          indentation = '  ' * indentation_depth

          print(indentation)
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
