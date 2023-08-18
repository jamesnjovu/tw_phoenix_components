defmodule TwPhoenixUi.Model do
  use Phoenix.Component
  alias Phoenix.LiveView.JS
  import TwPhoenixUi.Gettext

  def name(assigns) do
    ~H"""
    ...
    """
  end

  attr :id, :any, default: nil
  attr :title, :string, default: nil
  attr :return_to, :string, default: "close_small_modal"
  def small(assigns) do
    ~H"""
      <div
        id={@id}
        phx-mounted={@show && show_modal(@id)}
        phx-remove={hide_modal(@id)}
        class="relative z-50 hidden"
      >
        <div id={"#{@id}-bg"} class="fixed inset-0 bg-black-50/90 transition-opacity" aria-hidden="true" />
        <div
          style="backdrop-filter: blur(5px);background-color: rgba(0, 0, 0, 0.4);"
          class="fixed inset-0 overflow-y-auto"
          aria-labelledby={"#{@id}-title"}
          aria-describedby={"#{@id}-description"}
          role="dialog"
          aria-modal="true"
          tabindex="0"
        >
          <div class="flex min-h-full  items-center justify-center">
            <div id="modal-content"
                class="inline-block overflow px-4 pt-5 pb-4 text-left align-bottom bg-white rounded-lg shadow-xl transition-all transform phx-modal-content sm:my-8 sm:align-middle sm:max-w-2xl sm:w-full sm:p-6" role="dialog" aria-modal="true" aria-labelledby="modal-headline"
                phx-click-away={@return_to}
                phx-window-keydown={@return_to}
                phx-key="escape">
              <div class="w-full max-w-3xl">
                <div class="absolute top-6 left-5"><%= @title %></div>
                <div class="absolute top-6 right-5">
                  <button
                    phx-click={@return_to}
                    type="button"
                    class="-m-3 flex-none p-3 opacity-20 hover:opacity-40"
                    aria-label={gettext("close")}
                  >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="h-5 w-5 stroke-current">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                  </button>
                </div>
              </div>
              <%= render_slot(@inner_block) %>
            </div>
          </div>
        </div>
      </div>
    """
  end

  attr :id, :any, default: nil
  attr :code, :string, default: "{}"
  attr :title, :string, default: "Code"
  attr :return_to, :string, default: "close_code_preview_model"
  def code_preview(assigns) do
    ~H"""
      <div
        id={@id}
        phx-mounted={@show && show_modal(@id)}
        phx-remove={hide_modal(@id)}
        class="relative z-50 hidden"
      >
        <div id={"#{@id}-bg"} class="fixed inset-0 bg-black-50/90 transition-opacity" aria-hidden="true" />
        <div
          style="backdrop-filter: blur(5px);background-color: rgba(0, 0, 0, 0.4);"
          class="fixed inset-0 overflow-y-auto"
          aria-labelledby={"#{@id}-title"}
          aria-describedby={"#{@id}-description"}
          role="dialog"
          aria-modal="true"
          tabindex="0"
        >
          <div class="flex min-h-full  items-center justify-center">
            <div id="modal-content"
                class="inline-block overflow px-4 pt-5 pb-4 text-left align-bottom bg-white rounded-lg shadow-xl transition-all transform phx-modal-content sm:my-8 sm:align-middle sm:max-w-2xl sm:w-full sm:p-6" role="dialog" aria-modal="true" aria-labelledby="modal-headline"
                phx-click-away={@return_to}
                phx-window-keydown={@return_to}
                phx-key="escape">
              <div class="w-full max-w-3xl p-4 sm:p-6 lg:py-8">
                <div class="absolute top-6 left-5"><%= @title %></div>
                <div class="absolute top-6 right-5">
                  <button
                    phx-click={@return_to}
                    type="button"
                    class="-m-3 flex-none p-3 opacity-20 hover:opacity-40"
                    aria-label={gettext("close")}
                  >
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="h-5 w-5 stroke-current">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                  </button>
                </div>
              </div>
                <article class="prose prose-img:rounded-xl prose-headings:underline prose-a:text-blue-600 w-full max-w-3xl">
                  <%= if !String.contains?(String.downcase(@title), "endpoint") do %>
                    <.preview_code code={@code} />
                  <% else %>
                    <.preview_code_text code={@code} />
                  <% end %>
                </article>
            </div>
          </div>
        </div>
      </div>
    """
  end

  attr :code, :string, required: true
  defp preview_code(assigns) do
    ~H"""
    <pre x-data={"{ message: JSON.stringify(#{String.trim(@code)}, undefined, 2) }"} x-text="message"></pre>
    """
  end

  attr :code, :string, required: true
  defp preview_code_text(assigns) do
    ~H"""
    <pre><%= String.trim(@code) %></pre>
    """
  end

  attr :id, :any, required: true
  attr :params, :string, default: ""
  attr :reject_text, :string, default: "Cancel"
  attr :agree_text, :string, default: "Proceed"
  attr :reject_function, :string, default: "reject"
  def confirmation_model(assigns) do
    ~H"""
    <div
      id={@id}
      phx-mounted={@show && show_modal(@id)}
      phx-remove={hide_modal(@id)}
      class="relative z-50" aria-labelledby="modal-title" role="dialog" aria-modal="true">
    <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"></div>

    <div class="fixed inset-0 z-10 overflow-y-auto"
        style="display: block; padding-right: 15px; background-color: rgba(0, 0, 0, 0.4); backdrop-filter: blur(5px);">
      <div class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
        <div class="relative transform overflow-hidden rounded-lg bg-white px-4 pt-5 pb-4 text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg sm:p-6">
          <div>
            <div class="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-green-100">
              <%= if @icon == "check" do %>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="h-6 w-6 text-green-600">
                  <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12zm13.36-1.814a.75.75 0 10-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 00-1.06 1.06l2.25 2.25a.75.75 0 001.14-.094l3.75-5.25z" clip-rule="evenodd" />
                </svg>
              <% end %>
              <%= if @icon == "exclamation_circle" do %>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6 text-green-600">
                  <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12zM12 8.25a.75.75 0 01.75.75v3.75a.75.75 0 01-1.5 0V9a.75.75 0 01.75-.75zm0 8.25a.75.75 0 100-1.5.75.75 0 000 1.5z" clip-rule="evenodd" />
                </svg>
              <% end %>
              <%= if @icon == "loading" do %>
                <div class="animate-spin">
                  <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" id="loading">
                    <path d="M27.02 22.82a.182.182 1080 1 0 .364 0 .182.182 1080 1 0-.364 0zm-4.018 4.146a.362.362 1080 1 0 .724 0 .362.362 1080 1 0-.724 0zM17.586 29.1a.544.544 1080 1 0 1.088 0 .544.544 1080 1 0-1.088 0zm-5.83-.286a.724.724 1080 1 0 1.448 0 .724.724 1080 1 0-1.448 0zM6.584 26.16a.906.906 1080 1 0 1.812 0 .906.906 1080 1 0-1.812 0zm-3.582-4.512a1.088 1.088 1080 1 0 2.176 0 1.088 1.088 1080 1 0-2.176 0zm-1.344-5.54a1.268 1.268 1080 1 0 2.536 0 1.268 1.268 1080 1 0-2.536 0zm1.106-5.504a1.45 1.45 1080 1 0 2.9 0 1.45 1.45 1080 1 0-2.9 0zm3.318-4.438a1.632 1.632 1080 1 0 3.264 0 1.632 1.632 1080 1 0-3.264 0zm4.872-2.542a1.812 1.812 1080 1 0 3.624 0 1.812 1.812 1080 1 0-3.624 0zm5.472-.158a1.994 1.994 1080 1 0 3.988 0 1.994 1.994 1080 1 0-3.988 0zm5.01 2.254a2.174 2.174 1080 1 0 4.348 0 2.174 2.174 1080 1 0-4.348 0zm3.56 4.234a2.356 2.356 1080 1 0 4.712 0 2.356 2.356 1080 1 0-4.712 0zm1.416 5.484a2.538 2.538 1080 1 0 5.076 0 2.538 2.538 1080 1 0-5.076 0z"></path>
                  </svg>
                </div>
              <% end %>
            </div>
            <div class="mt-3 text-center sm:mt-5">
              <h3 class="text-lg font-medium leading-6 text-gray-900" id="modal-title"><%= @model_title %></h3>
              <div class="mt-2">
                <p class="text-sm text-gray-500"><%= @body_text %></p>
              </div>
            </div>
          </div>
          <%= if @icon != "loading" do %>
            <div class="mt-5 sm:mt-6 sm:grid sm:grid-flow-row-dense sm:grid-cols-2 sm:gap-3">
              <button type="button"  phx-click={@agree_function} phx-value-params={@params} class="inline-flex w-full justify-center rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 sm:col-start-2 sm:text-sm"><%= @agree_text %></button>
              <button type="button" phx-click={@reject_function} class="mt-3 inline-flex w-full justify-center rounded-md border border-gray-300 bg-white px-4 py-2 text-base font-medium text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 sm:col-start-1 sm:mt-0 sm:text-sm"><%= @reject_text %></button>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    </div>
    """
  end

  ## JS Commands

  def show(js \\ %JS{}, selector) do
    JS.show(js,
      to: selector,
      transition:
        {"transition-all transform ease-out duration-300",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  def hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all transform ease-in duration-200",
         "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end

  def show_modal(js \\ %JS{}, id) when is_binary(id) do
    js
    |> JS.show(to: "##{id}")
    |> JS.show(
      to: "##{id}-bg",
      transition: {"transition-all transform ease-out duration-300", "opacity-0", "opacity-100"}
    )
    |> show("##{id}-container")
    |> JS.add_class("overflow-hidden", to: "body")
    |> JS.focus_first(to: "##{id}-content")
  end

  def hide_modal(js \\ %JS{}, id) do
    js
    |> JS.hide(
      to: "##{id}-bg",
      transition: {"transition-all transform ease-in duration-200", "opacity-100", "opacity-0"}
    )
    |> hide("##{id}-container")
    |> JS.hide(to: "##{id}", transition: {"block", "block", "hidden"})
    |> JS.remove_class("overflow-hidden", to: "body")
    |> JS.pop_focus()
  end
end
