module TestBench
  class Session
    module Controls
      module File
        def self.example(contents=nil)
          contents ||= self.contents

          path = TestBench::Telemetry::Controls::File::Temporary.example

          ::File.write(path, contents)

          path
        end

        def self.contents = Pass.contents

        module Failure
          def self.example(session: nil)
            contents = contents(session:)

            File.example(contents)
          end

          def self.contents(session: nil)
            session ||= Session.new

            <<~RUBY
            session = ObjectSpace._id2ref(#{session.object_id})
            session.assert(false)
            RUBY
          end
        end

        module Pass
          def self.example
            File.example(contents)
          end

          def self.contents
            ''
          end
        end

        module Path
          def self.example(suffix=nil)
            extension = '.rb'

            filename = TestBench::Telemetry::Controls::File::Name.example(suffix, extension:)

            ::File.join('some_dir', 'some_other_dir', filename)
          end

          def self.random = example(Random.string)
        end
      end
    end
  end
end
