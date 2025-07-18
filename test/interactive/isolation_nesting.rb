require_relative 'interactive_init'

apex_directory = Controls::Path::ApexDirectory::Create.()
comment "Apex directory: #{apex_directory.inspect}"

master_pid = Process.pid
at_exit {
  if Process.pid == master_pid
    comment "Removing apex directory: #{apex_directory.inspect}"
    Controls::Path::ApexDirectory::Remove.(apex_directory)
  end
}

inner_file_path = Controls::Path::File::Create::Comment.(text: "Isolation nesting example", apex_directory:, relative: false)
comment "Inner File Path: #{inner_file_path.inspect}"

iterations = ENV.fetch('ITERATIONS', '1').to_i
comment "Iterations: #{iterations}"

file_path = iterations.times.reduce(inner_file_path) do |target_file_path, iteration|
  basename = "file-#{iteration + 1}"

  source_file_path = Controls::Path::File::Create.(<<~RUBY, basename:, apex_directory:, relative: false)
    Session.instance.execute('#{target_file_path}')
  RUBY

  comment "File ##{iteration + 1} Path: #{source_file_path.inspect}"

  source_file_path
end

session = Session.build(apex_directory:)

class CommentSink
  include Telemetry::Sink::Handler
  include Session::Events

  handle Commented do |commented|
    STDERR.puts "\e[1;35mComment: #{commented.text}\e[m"
  end
end
session.register_telemetry_sink(CommentSink.new)

session.execute(file_path)
