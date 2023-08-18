defmodule TwPhoenixUi.Card do
  use Phoenix.Component
  import Phoenix.HTML
  import TwPhoenixUi.Gettext

  attr :description, :string, default: ""
  attr :title, :string, required: true
  def dashboard(assigns) do
    ~H"""
    <div class="overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6">
        <dt class="truncate text-sm font-medium text-gray-500"><%= @title %></dt>
        <dd class="mt-1 text-3xl font-semibold tracking-tight text-gray-900"><%= @description %></dd>
    </div>
    """
  end

  attr :valid_record, :integer, default: 0
  attr :invalid_record, :integer, default: 0
  attr :total_record, :integer, default: 0
  attr :valid_record_callback, :string, default: "view_valid_records"
  attr :invalid_record_callback, :string, default: "view_invalid_records"
  def extract_validation(assigns) do
    ~H"""
    <dl class="mt-5 grid grid-cols-1 gap-4 sm:grid-cols-3">
        <button type="button" phx-click={@valid_record_callback}
                class="zoom-in overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6">
            <dt class="truncate text-sm font-medium text-gray-500">Valid record</dt>
            <dd class="mt-1 text-3xl font-semibold tracking-tight text-gray-900"><%= @valid_record %></dd>
        </button>
        <button type="button" phx-click={@invalid_record_callback} class="zoom-in overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6">
            <dt class="truncate text-sm font-medium text-gray-500">Invalid record</dt>
            <dd class="mt-1 text-3xl font-semibold tracking-tight text-gray-900"><%= @invalid_record %></dd>
        </button>
        <button type="button" class="overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6">
            <dt class="truncate text-sm font-medium text-gray-500">Total record</dt>
            <dd class="mt-1 text-3xl font-semibold tracking-tight text-gray-900"><%= @total_record %></dd>
        </button>
    </dl>
    """
  end

  attr :icon, :string, default: """
  <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M19.7712 13.1046C20.7714 12.1044 21.3333 10.7478 21.3333 9.33333C21.3333 7.91885 20.7714 6.56229 19.7712 5.5621C18.771 4.5619 17.4145 4 16 4C14.5855 4 13.2289 4.5619 12.2288 5.5621C11.2286 6.56229 10.6667 7.91885 10.6667 9.33333C10.6667 10.7478 11.2286 12.1044 12.2288 13.1046C13.2289 14.1048 14.5855 14.6667 16 14.6667C17.4145 14.6667 18.771 14.1048 19.7712 13.1046Z" stroke="#FBBF24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
    <path d="M9.40033 21.4003C11.1507 19.65 13.5246 18.6667 16 18.6667C18.4753 18.6667 20.8493 19.65 22.5997 21.4003C24.35 23.1507 25.3333 25.5246 25.3333 28H6.66666C6.66666 25.5246 7.64999 23.1507 9.40033 21.4003Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
  </svg>
  """
  attr :title, :string, required: true
  attr :value, :integer, required: true
  def metrics_with_icons(assigns) do
    ~H"""
    <div class="rounded-lg p-5 bg-white shadow-sm">
        <div class="flex items-center space-x-4">
            <div>
                <div class="flex items-center justify-center w-12 h-12 rounded-full bg-fuchsia-50 text-fuchsia-400">
                    <%= raw(@icon) %>
                </div>
            </div>
            <div>
                <div class="text-gray-400"><%= @title %></div>
                <div class="text-2xl font-bold text-gray-900"><%= @value %></div>
            </div>
        </div>
    </div>
    """
  end

  attr :icon, :string, default: """
  <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M19.7712 13.1046C20.7714 12.1044 21.3333 10.7478 21.3333 9.33333C21.3333 7.91885 20.7714 6.56229 19.7712 5.5621C18.771 4.5619 17.4145 4 16 4C14.5855 4 13.2289 4.5619 12.2288 5.5621C11.2286 6.56229 10.6667 7.91885 10.6667 9.33333C10.6667 10.7478 11.2286 12.1044 12.2288 13.1046C13.2289 14.1048 14.5855 14.6667 16 14.6667C17.4145 14.6667 18.771 14.1048 19.7712 13.1046Z" stroke="#FBBF24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
    <path d="M9.40033 21.4003C11.1507 19.65 13.5246 18.6667 16 18.6667C18.4753 18.6667 20.8493 19.65 22.5997 21.4003C24.35 23.1507 25.3333 25.5246 25.3333 28H6.66666C6.66666 25.5246 7.64999 23.1507 9.40033 21.4003Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
  </svg>
  """
  attr :title, :string, required: true
  attr :value, :integer, required: true
  def metrics_with_icons_rounded(assigns) do
    ~H"""
      <div class="relative flex flex-col min-w-0 break-words bg-white rounded-lg mb-6 xl:mb-0 shadow-lg">
        <div class="flex-auto p-4">
          <div class="flex flex-wrap">
            <div class="relative w-full pr-4 max-w-full flex-grow flex-1">
              <h5 class="text-blueGray-400 uppercase font-bold text-xs"><%= @title %></h5>
              <span class="font-bold text-xl"><%= @value %></span>
            </div>
            <div class="relative w-auto pl-4 flex-initial">
              <%= raw(@icon) %>
            </div>
          </div>
          <p class="text-sm text-blueGray-500 mt-4">
          <span class="text-emerald-500 mr-2"><i class="fas fa-arrow-up"></i></span>
          <span class="whitespace-nowrap"> </span></p>
        </div>
      </div>
    """
  end
end
