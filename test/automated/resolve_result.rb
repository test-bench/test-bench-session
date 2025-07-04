require_relative 'automated_init'

context "Resolve Result" do
  context "Strict" do
    strict = true

    [
      [Result.passed, true],
      [Result.failed, false],
      [Result.none, false],
      [Result.aborted, false],
      [Result.incomplete, false]
    ].each do |result, control_value|
      context "#{result.capitalize}" do
        value = Result.resolve(result, strict:)

        comment value.inspect
        detail "Control: #{control_value.inspect}"

        test do
          assert(value == control_value)
        end
      end
    end
  end

  context "Non-Strict" do
    strict = false

    [
      [Result.passed, true],
      [Result.failed, false],
      [Result.none, true],
      [Result.aborted, false],
      [Result.incomplete, true]
    ].each do |result, control_value|
      context "#{result.capitalize}" do
        value = Result.resolve(result, strict:)

        comment value.inspect
        detail "Control: #{control_value.inspect}"

        test do
          assert(value == control_value)
        end
      end
    end
  end
end
