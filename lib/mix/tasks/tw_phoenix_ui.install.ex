defmodule Mix.Tasks.TwPhoenixUi.Install do
  @moduledoc """
  Installs multi_select component in the existing project.

  ```bash
  $ mix tw_phoenix_ui.install
  ```
  """

  @shortdoc "Installs MultiSelect component"
  use Mix.Task


  @impl true
  def run(_args) do
    modify_npm_cfg()
    :ok
  end

  defp modify_npm_cfg() do
    file = "assets/package.json"
    if File.exists?(file) and (File.read!(file) =~ "alpinejs") do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D alpinejs), cd: "assets")
      IO.puts("==> Added alpinejs NPM dev package")
    end

    if File.exists?(file) and (File.read!(file) =~ "@alpinejs/collapse") do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D @alpinejs/collapse), cd: "assets")
      IO.puts("==> Added alpinejs/collapse NPM dev package")
    end

    if File.exists?(file) and (File.read!(file) =~ "@alpinejs/focus") do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D @alpinejs/focus), cd: "assets")
      IO.puts("==> Added alpinejs/focus NPM dev package")
    end
  end

  defp check_alpinejs() do
    if Application.get_env(:phoenix_multi_select, :use_alpinejs) do
      found =
        case Path.wildcard("lib/**/root.html.heex") do
          [root_html] -> File.read!(root_html) =~ ~r/<[^s]*script.+alpinejs/
          []          -> false
        end
      file  = "assets/js/app.js"
      found = found ||
        case File.exists?(file) do
          true  ->
            File.read!(file) =~ ~r/import.+alpinejs/
          false -> false
        end
      if not found do
        IO.puts("""
          ==> Configuration option `config :phoenix_multi_select, use_alpinejs: true`
          ==> requires that AlpineJS is available.
          ==>
          ==> However AlpineJS configuration is missing! You either need to include:
          ==>
          ==>   <script src="//unpkg.com/alpinejs" defer></script>
          ==>
          ==> in the root.html.heex template, or add this to the assets/js/app.js:
          ==>
          ==>   import 'alpinejs'
          ==>
          ==>   Alpine.plugin(collapse)
          ==>   Alpine.plugin(focus)
          ==>   window.Alpine = Alpine
          ==>   Alpine.start()
          """)
      end
    end
  end

  defp out(str), do:
    (System.get_env("DEBUG", "0") |> String.to_integer() > 0) && IO.puts(str)
end
