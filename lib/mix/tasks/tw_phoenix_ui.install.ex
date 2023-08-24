defmodule Mix.Tasks.TwPhoenixUi.Install do
  @moduledoc """
  Installs multi_select component in the existing project.

  ```bash
  $ mix tw_phoenix_ui.install
  ```
  """

  @shortdoc "Installs tw_phoenix_ui component"

  use Mix.Task
  alias Mix.Tasks.Phx.Gen

  @impl true
  def run(_args) do
    # modify_npm_cfg()
    modify_app_web_cfg()
    :ok
  end

  defp modify_npm_cfg() do
    file = "assets/package.json"

    if File.exists?(file) and File.read!(file) =~ "alpinejs" do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D alpinejs), cd: "assets")
      IO.puts("==> Added alpinejs NPM dev package")
    end

    if File.exists?(file) and File.read!(file) =~ "alpinejs/collapse" do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D @alpinejs/collapse), cd: "assets")
      IO.puts("==> Added alpinejs/collapse NPM dev package")
    end

    if File.exists?(file) and File.read!(file) =~ "alpinejs/focus" do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D @alpinejs/focus), cd: "assets")
      IO.puts("==> Added alpinejs/focus NPM dev package")
    end

    # npm install -D @tailwindcss/typography
    if File.exists?(file) and File.read!(file) =~ "tailwindcss/typography" do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D @tailwindcss/typography), cd: "assets")
      IO.puts("==> Added tailwindcss/typography NPM dev package")
    end
  end

  def modify_app_web_cfg() do
    context_app = Mix.Phoenix.context_app()
    file = "lib/#{context_app}_web.ex"
    out("""
    ==> #{file}
    ==> #{File.read!(file)}
    """)
  end

  defp check_alpinejs() do
    found =
      case Path.wildcard("lib/**/root.html.heex") do
        [root_html] -> File.read!(root_html) =~ ~r/<[^s]*script.+alpinejs/
        [] -> false
      end

    file = "assets/js/app.js"

    found =
      found ||
        case File.exists?(file) do
          true ->
            File.read!(file) =~ ~r/import.+alpinejs/

          false ->
            false
        end

    out("""
    ==> /assets/js/app.js

    ==> requires that AlpineJS is available.
    ==>
    ==> However AlpineJS configuration is missing! You either need to include:
    ==>
    ==>   <script src="//unpkg.com/alpinejs" defer></script>
    ==>
    ==> in the root.html.heex template, or add this to the assets/js/app.js:
    ==>
    ==>   import Alpine from "alpinejs";
    ==>   import collapse from '@alpinejs/collapse'
    ==>   import focus from '@alpinejs/focus'
    ==>
    ==>   Alpine.plugin(collapse)
    ==>   Alpine.plugin(focus)
    ==>   window.Alpine = Alpine
    ==>   Alpine.start()
    """)
  end

  defp app_web_context() do
    """
    alias TwPhoenixUi.{
      Card,
      Model,
      Option,
      Table,
      TopNav
    }
    """
  end
  defp out(str), do: System.get_env("DEBUG", "0") |> String.to_integer() > 0 && IO.puts(str)
end
