defmodule Counter do

  def inc(counter), do: send(counter, :inc)
  def dec(counter), do: send(counter, :dec)

  def val(counter, timeout \\ 5000) do
    ref = make_ref()
    send(counter, {:val, ref, self()})
    receive do
      {:val, ^ref, val} -> val
    after timeout -> exit(:timeout)
    end
  end

  def start_link(initial_value \\ 0) do
    {:ok,
     spawn_link(fn ->
       Process.register(self(), __MODULE__)
       listen(initial_value)
     end)}
  end

  defp listen(val) do
    receive do
      :inc -> listen(val + 1)
      :dec -> listen(val - 1)
      {:val, ref, sender} ->
        send sender, {:val, ref, val}
        listen(val)
    end
  end
end
