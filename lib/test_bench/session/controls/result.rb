module TestBench
  class Session
    module Controls
      module Result
        def self.example = pass
        def self.pass = true
        def self.failure = false
        def self.random = Random.boolean
      end
    end
  end
end
