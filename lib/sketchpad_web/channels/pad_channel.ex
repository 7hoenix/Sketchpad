defmodule SketchpadWeb.PadChannel do
  use SketchpadWeb, :channel

  # this is process specific for each browser
  def join("pad:" <> pad_id, _params, socket) do
    IO.puts ">> #{socket.assigns.user_id} joined pad #{pad_id}"
    {:ok, %{msg: "hi"}, assign(socket, :pad_id, pad_id)}
  end
end
