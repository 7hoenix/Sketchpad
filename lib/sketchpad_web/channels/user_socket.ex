defmodule SketchpadWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "pad:*", SketchpadWeb.PadChannel
  # "user:user_id" for global communication messaging to all users

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user token", token, max_age: 86400) do
      {:ok, user_id} ->
        IO.puts ">> verified #{user_id}"
        {:ok, assign(socket, :user_id, user_id)}

      {:error, _reason} ->
        IO.puts ">> failed to verify user"
        :error
    end
  end

  def id(_socket), do: nil
end
