require_relative 'automated_init'

context "Handler" do
  context "Handler Implements Event Handler for Event" do
    data = Controls::Random.string
    event = Controls::Handler::Event.example(data)

    handler = Controls::Handler.example
    handler.handle(event)

    test "Event is handled" do
      assert(handler.handled?(event))
    end
  end

  context "Handler Doesn't Implement Event Handler for Event" do
    event = Controls::Handler::Event.other_example

    handler = Controls::Handler.example
    handler.handle(event)

    test "Event isn't handled" do
      refute(handler.handled?)
    end
  end
end
