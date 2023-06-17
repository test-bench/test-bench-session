require_relative 'interactive_init'

puts <<~TEXT

Session Store
= = =

\e[3m(Nothing has been put)\e[23m
Put: #{Session::Store.put? ? 'yes' : 'no'}
Get: #{Session::Store.get.inspect}
TEXT

fetch_session = Session::Store.fetch
puts <<~TEXT
Fetch: #{fetch_session}
  Telemetry Sinks: #{fetch_session.telemetry.sinks.map(&:class).join(', ')}

TEXT

Session::Store.reset

put_session = Session.build do |telemetry|
  telemetry.register(Telemetry::Controls::Sink.example)
end
Session::Store.put(put_session)

puts <<~TEXT
\e[3m(Session has been put)\e[23m
Put: #{Session::Store.put? ? 'yes' : 'no'}
Get: #{Session::Store.get.inspect}
TEXT

fetch_session = Session::Store.fetch
puts <<~TEXT
Fetch: #{fetch_session}
  Telemetry Sinks: #{fetch_session.telemetry.sinks.map(&:class).join(', ')}

TEXT

reset_session = Session.build
Session::Store.reset(reset_session)

puts <<~TEXT
\e[3m(Session has been reset)\e[23m
Put: #{Session::Store.put? ? 'yes' : 'no'}
Get: #{Session::Store.get.inspect}

TEXT
