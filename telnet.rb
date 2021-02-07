require 'socket'

host, port = ARGV

begin
  STDOUT.print "Подключение..."
  STDOUT.flush
  s = TCPSocket.open(host,port)
  STDOUT.puts "готово"

  local, peer = s.addr, s.peeraddr
  STDOUT.print "Осуществлено подключение к #{peer[2]}: #{peer[1]}"
  STDOUT.puts " используется локальный порт #{local[1]}"

  begin
    sleep(0.5)
    msg = s.read_nonblock(4096)
    STDOUT.puts msg.chop
  rescue SystemCallError

  end

  loop do
    STDOUT.print '> '
    STDOUT.flush
    local = STDIN.gets
    break if !local

    s.puts(local)
    s.flush
    responce = s.readpartial(4096)
    puts(responce.chop)
  end
rescue
  puts $!
ensure
  s.close if s
end


