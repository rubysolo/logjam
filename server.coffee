connect  = require 'connect'
socketio = require 'socket.io'
Tail     = require('tail').Tail
ansi_up  = require 'ansi_up'

port = process.env.PORT || 8888
app  = connect.createServer(connect.static('public')).listen port
io   = socketio.listen app
console.log "[logjam] listening on #{ port }..."

fileName = process.env.FILE
tail     = new Tail fileName

tail.on 'line', (data) ->
  io.sockets.emit 'new-data',
    channel: 'stdout'
    value:   ansi_up.ansi_to_html(data)

io.sockets.on 'connection', (socket) ->
  socket.emit 'new-data',
    channel: 'stdout'
    value:   "[logjam] tailing file #{ fileName }..."
