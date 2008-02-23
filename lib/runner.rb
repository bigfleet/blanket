class Runner
  attr_accessor :buffer
  def initialize
    @buffer = ""
  end

  def do_command( session, command )
    session.open_channel do |channel|
      channel.on_data do |ch, data|
        @buffer += "[#{command}] -> #{data}"
      end
      channel.exec "#{command}"
    end
  end

  def connect(command, host, username = nil, password = nil)
    Net::SSH.start( host, username, password ) do |session|
      do_command session, "#{command}"
      session.loop
    end
  end
end