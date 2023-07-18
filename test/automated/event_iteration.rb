require_relative 'automated_init'

context "Event Iteration" do
  event_types = Session::Events.each_type.to_a
  control_event_types = Controls::Events.examples.map(&:event_type)

  comment event_types.inspect
  detail "Control: #{control_event_types.inspect}"

  test do
    assert(event_types == control_event_types)
  end
end
