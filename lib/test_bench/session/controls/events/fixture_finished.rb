module TestBench
  class Session
    module Controls
      module Events
        module FixtureFinished
          def self.example(name: nil, result: nil, process_id: nil, time: nil)
            name ||= self.name
            result = self.result if result.nil?
            process_id ||= self.process_id
            time ||= self.time

            Session::Events::FixtureFinished.build(name, result, process_id:, time:)
          end

          def self.random
            name = Fixture::Name.random
            result = Result.random
            process_id = ProcessID.random
            time = Time.random

            example(name:, result:, process_id:, time:)
          end

          def self.name = Fixture::Name.example
          def self.result = Result.example
          def self.process_id = ProcessID.example
          def self.time = Time.example
        end
      end
    end
  end
end
