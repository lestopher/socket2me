connection = null
connectionUri = "ws://localhost:4568"
output = null

init = ->
  output = document.getElementById("main")
  testWebSocket()

testWebSocket = ->
  connection = new WebSocket(connectionUri)
  connection.onopen = (evt) -> onOpen(evt)
  connection.onclose = (evt) -> onClose(evt)
  connection.onmessage = (evt) -> onMessage(evt)
  connection.onerror = (evt) -> onError(evt)

onOpen = (evt) ->
  writeToScreen("Connected.")
  doSend("WebSockets Rocks")

onClose = (evt) ->
  writeToScreen("Disconnected")

onMessage = (evt) ->
  writeToScreen('<span style="color: blue;">RESPONSE: ' + evt.data+'</span>')

onError = (evt) ->
  writeToScreen('<span style="color: red;">ERROR:' + evt.data + '</span>' )

doSend = (message) ->
  writeToScreen("SENT: " + message)
  connection.send(message)

writeToScreen =  (message) ->
  pre = document.createElement("p")
  pre.style.wordWrap = "break-word"
  pre.innerHTML = message
  output.appendChild(pre)

clickHandler = (evt) ->
  if evt.target.id == "connect-btn"
    connectBtnClick(evt)
  else if evt.target.id == "disconnect-btn"
    disconnectBtnClick(evt)
  else if evt.target.id == "submit-auth-btn"
    submitAuthBtnClick(evt)

connectBtnClick = (evt) ->
  output = document.getElementById('main')
  connection = new WebSocket connectionUri
  connection.onopen = (evt) -> onOpen(evt)
  connection.onclose = (evt) -> onClose(evt)
  connection.onmessage = (evt) -> onMessage(evt)
  connection.onerror = (evt) -> onError(evt)

disconnectBtnClick = (evt) ->
  connection.close()

submitAuthBtnClick = (evt) ->
  inputBox = document.getElementById("command-input")
  doSend(inputBox.value)

# window.addEventListener("DOMContentLoaded", init, false);
window.addEventListener("click", clickHandler, false);
