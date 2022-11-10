module TestBench
  class Session
    module Controls
      module Events
        def self.examples(random: nil)
          random ||= false

          if random
            method_name = :random
          else
            method_name = :example
          end

          controls = Session::Events.each_type.map do |event_type|
            Events.const_get(event_type, false)
          end

          controls.map(&method_name)
        end

        def self.each_example(random: nil, &block)
          examples(random:).each(&block)
        end
      end
    end
  end
end
