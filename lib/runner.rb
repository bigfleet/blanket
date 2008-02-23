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

  def go
    Net::SSH.start( 'jimvanfleet.is-a-geek.com', 'bigfleet', '2021nd' ) do |session|
      do_command session, "ls ~"
      session.loop
    end
  end
end