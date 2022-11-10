module TestBench
  class Session
    module Controls
      module Events
        module FixtureStarted
          def self.example(name: nil, process_id: nil, time: nil)
            name ||= self.name
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::FixtureStarted.new(name, process_id, time)
          end

          def self.random
            name = Fixture::Name.random
            process_id = ProcessID.random
            time = Time.random

            example(name:, process_id:, time:)
          end

          def self.name = Fixture::Name.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
