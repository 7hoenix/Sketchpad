import "phoenix_html"
import {Socket, Presence} from "phoenix"
import {Sketchpad, sanitize} from "./sketchpad"
import socket from "./socket"

socket.connect()

let App = {
  init(){
    this.padChannel = socket.channel("pad:lobby")
    this.el = document.getElementById("sketchpad")
    this.pad = new Sketchpad(this.el, window.userId)

    this.padChannel.join()
      .receive("ok", resp => console.log("joined", resp))
      .receive("error", err => console.log("failed to join", err))
  }
}

App.init()
