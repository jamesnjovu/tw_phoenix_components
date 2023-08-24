defmodule Mix.Tasks.TwPhoenixUi.Install do
  @moduledoc """
  Installs multi_select component in the existing project.

  ```bash
  $ mix tw_phoenix_ui.install
  ```
  """

  @shortdoc "Installs tw_phoenix_ui component"

  use Mix.Task

  @impl true
  def run(_args) do
    modify_npm_cfg()
    modify_app_web_cfg()
    install_alpinejs()
    :ok
  end

  defp modify_npm_cfg() do
    file = "assets/package.json"

    if File.exists?(file) and File.read!(file) =~ "alpinejs" do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D alpinejs), cd: "assets")
      out("==> Added alpinejs NPM dev package")
    end

    if File.exists?(file) and File.read!(file) =~ "alpinejs/collapse" do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D @alpinejs/collapse), cd: "assets")
      out("==> Added alpinejs/collapse NPM dev package")
    end

    if File.exists?(file) and File.read!(file) =~ "alpinejs/focus" do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D @alpinejs/focus), cd: "assets")
      out("==> Added alpinejs/focus NPM dev package")
    end

    if File.exists?(file) and File.read!(file) =~ "tailwindcss/typography" do
      out("==> File #{file} doesn't require modifications")
    else
      {_, 0} = System.cmd("npm", ~w(install -D @tailwindcss/typography), cd: "assets")
      out("==> Added tailwindcss/typography NPM dev package")
    end
  end

  defp modify_app_web_cfg() do
    context_app = Mix.Phoenix.context_app()
    index = "lib/#{context_app}_web.ex"

    found =
      case File.exists?(index) do
        true ->
          File.read!(index) =~ ~r/import.+alpinejs/

        false ->
          false
      end

    if found do
      f = File.read!(index)

      str =
        case Regex.run(~r/\n\s*defp\s+html_helpers\s+do\s+quote\s+do/, f, return: :index) do
          [{n, m}] ->
            {s1, s2} = String.split_at(f, n + m)

            if s2 =~ app_web_context() do
              f
            else
              s2 = String.trim_leading(s2, "\n")
              s1 <> "\n  #{app_web_context()} \n" <> s2
            end

          _ ->
            f <> "\defp html_helpers do\nquote do\n  #{app_web_context()}\nend\nend"
        end

      if f != str do
        File.write!(index, str)
        out("==> File #{index} modified")
      else
        out("==> File #{index} doesn't require modifications")
      end
    end
  end

  defp install_alpinejs() do
    index = "assets/js/app.js"
    f = File.read!(index)

    str =
      case Regex.run(~r/\n\s*import\s+\w+\s+from\s+"[^"]+"/, f, return: :index) do
        [{n, m}] ->
          {s1, s2} = String.split_at(f, n + m)
          str = if f =~ "import Alpine", do: "", else: "import Alpine from \"alpinejs\"\n"

          str =
            if str =~ "import collapse from '@alpinejs/collapse'",
              do: "",
              else: str <> "import collapse from \"@alpinejs/collapse\"\n"

          str =
            if str =~ "import focus from '@alpinejs/focus'",
              do: "",
              else: str <> "import collapse from \"@alpinejs/focus\"\n"

          s1 <> "\n  #{str} \n" <> s2

        _ ->
          f
      end

    str =
      case Regex.run(
             ~r/\n\s*document\.querySelector\("meta\[name='csrf-token'\]"\)\.getAttribute\("content"\)/,
             str,
             return: :index
           ) do
        [{n, m}] ->
          {s1, s2} = String.split_at(str, n + m)
          str1 = if str =~ "Alpine.plugin(collapse)", do: "", else: "Alpine.plugin(collapse)\n"
          str1 = if str1 =~ "Alpine.plugin(focus)", do: "", else: str1 <> "Alpine.plugin(focus)\n"
          str1 = if str1 =~ "window.Alpine", do: "", else: str1 <> "window.Alpine = Alpine\n"
          str1 = if str1 =~ "Alpine.start()", do: "", else: str1 <> "Alpine.start()\n"
          strw = s1 <> "\n  #{str1} \n" <> s2

          out("""
          ===> assets/js/app.js
          //Change FROM
          let liveSocket = new LiveSocket("/live", Socket, {
              params: {_csrf_token: csrfToken}
          })
          // Change TO
          let liveSocket = new LiveSocket("/live", Socket, {
              params: {_csrf_token: csrfToken},
              dom: {
                  onBeforeElUpdated(from, to) {
                      if (from._x_dataStack) {
                          window.Alpine.clone(from, to);
                      }
                  }
              }
          })
          """)

        _ ->
          str
      end

    if f != str do
      File.write!(index, str)
      out("==> File #{index} modified")
    else
      out("==> File #{index} doesn't require modifications")
    end
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

  defp out(str), do: IO.puts(str)
end
