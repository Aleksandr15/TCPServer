require 'socket'

server = TCPServer.open(3000)
loop do
  client = server.accept
  client.puts(Time.now.ctime)
  client.close
end
