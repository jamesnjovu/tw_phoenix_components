defmodule TwPhoenixUi.TopNav do
  use Phoenix.Component

  attr :name, :string, default: ""
  attr :user_name, :string, default: ""
  attr :logo_alt, :string, default: "Your Company"
  attr :logo, :string, default: "https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=500"
  attr :profile_pic, :string, default: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"

  slot :inner_block, required: true
  def top_section(assigns) do
    ~H"""
    <nav class="bg-white to-[#F3A12E] border-b-2 border-[#379FA7]">
      <div class="mx-auto container px-2 sm:px-6 lg:px-8">
        <div class="relative flex h-14 items-center justify-between">
          <div class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">
            <div class="flex flex-shrink-0 items-center">
              <img class="block h-8 w-auto lg:hidden" src={@logo} alt={@logo_alt}>
              <img class="hidden h-12 w-auto lg:block" src={@logo} alt={@logo_alt}>
              <span class="text-[#F3A12E] pl-2">
                <%= @name %>
              </span>
            </div>
          </div>
          <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
            <%= @user_name %>
            <!-- Profile dropdown -->
            <div class="relative ml-3" x-data="{ProfileDropdown: false}">
              <div>
                <button type="button" x-on:click="ProfileDropdown = !ProfileDropdown"
                  class="flex rounded-full  text-sm focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800" id="user-menu-button" aria-expanded="false" aria-haspopup="true">
                  <span class="sr-only">Open user menu</span>
                  <img class="h-8 w-8 rounded-full" src={@profile_pic} alt="">
                </button>
              </div>
              <div
                x-cloak
                x-show="ProfileDropdown"
                x-on:click.outside="ProfileDropdown = false"
                x-transition:enter="transition ease-out duration-100"
                x-transition:enter-start="transform opacity-0 scale-95"
                x-transition:enter-end="transform opacity-100 scale-100"
                x-transition:leave="transition ease-in duration-75"
                x-transition:leave-start="transform opacity-100 scale-100"
                x-transition:leave-end="transform opacity-0 scale-95"
                class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="user-menu-button" tabindex="-1">
                <!-- Active: "", Not Active: "" -->
                <%= render_slot(@inner_block) %>
              </div>
            </div>
          </div>
        </div>
      </div>
    </nav>
    """
  end

  attr :text, :string, default: "menu"
  attr :navigate, :string, default: "/"
  def top_section_profile_item(assigns) do
    ~H"""
    <.link navigate={@navigate}
      class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
      role="menuitem" tabindex="-1" id="user-menu-item-0">
      <%= @text %>
    </.link>
    """
  end

  attr :background, :string, default: "bg-brand-1"

  slot :inner_block, required: true
  def menu(assigns) do
    ~H"""
    <nav class={"#{@background} shadow"} x-data="{navbarOpen:false}">
      <!-- container -->
      <div class="container flex flex-wrap px-4 py-2 mx-auto lg:space-x-4 flex justify-center">
        <button
          class="inline-flex items-center justify-center w-10 h-10 ml-auto text-gray-600 border rounded-md outline-none  lg:hidden focus:outline-none"
          x-on:click="navbarOpen = !navbarOpen"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="w-6 h-6"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M4 6h16M4 12h16M4 18h16"
            />
          </svg>
        </button>
        <!-- toggler btn -->
        <!-- menu -->
        <div
          class="w-full mt-2 lg:inline-flex lg:w-auto lg:mt-0"
          x-bind:class="{'hidden':!navbarOpen,'flex':navbarOpen}"
        >
          <ul
            class="flex flex-col w-full space-y-2  lg:w-auto lg:flex-row lg:space-y-0 lg:space-x-2"
          >
          <%= render_slot(@inner_block) %>
          </ul>
        </div>
        <!-- menu -->
      </div>
      <!-- container -->
    </nav>
    """
  end

  attr :title, :string, default: ""
  attr :navigate, :string, default: "/"
  attr :active, :boolean, default: false
  attr :active_class, :string, default: "text-gray-600"
  attr :class, :string, default: "text-gray-600 hover:bg-brand-2"

  slot :inner_block, required: true
  def item(assigns) do
    ~H"""
    <li>
      <.link
        navigate={@navigate}
        class={[
          "flex px-4 py-2 font-medium #{@class} rounded-md",
          @active && @active_class
        ]}
      >
        <%= @title %>
      </.link>
    </li>
    """
  end

  attr :title, :string, default: "Dropdown"
  attr :dropdown_class, :string, default: "bg-white"
  attr :button_class, :string, default: "text-gray-600 hover:bg-brand-2"

  slot :inner_block, required: true
  def dropdown(assigns) do
    ~H"""
    <li class="relative" x-data="{dropdownOpen: false}">
      <button
        type="button"
        class={"flex w-full px-4 py-2 font-medium #{@button_class} rounded-md outline-none gap-x-1.5 focus:outline-none"}
        @mouseleave="function handleClick(e) {
          width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
          if (width > 1023) {
            dropdownOpen = false
          }
        }"
        @mouseover="function handleClick(e) {
          width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
          if (width > 1023) {
            dropdownOpen = true
          }
        }"
        x-on:click="dropdownOpen = !dropdownOpen"
      >
        <%= @title %>
        <svg x-bind:class="{ '-rotate-180' : dropdownOpen==true }"
          class="relative top-[1px] -mr-1 h-5 w-5 text-gray-400 ease-out duration-300"
          xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
          stroke="currentColor" stroke-width="2" stroke-linecap="round"
          stroke-linejoin="round" aria-hidden="true">
          <polyline points="6 9 12 15 18 9"></polyline>
        </svg>
      </button>
      <!-- dropdown menu -->
      <div
        x-cloak
        x-show="dropdownOpen"
        @mouseleave="function handleClick(e) {
          width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
          if (width > 1023) {
            dropdownOpen = false
          }
        }"
        x-on:click.away="function handleClick(e) {
          width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
          if (width <= 1023) {
            dropdownOpen = false
          }
        }"
        @mouseover="function handleClick(e) {
          width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
          if (width > 1023) {
            dropdownOpen = true
          }
        }"
        x-transition:enter="transition ease-out duration-300"
        x-transition:enter-start="transform opacity-0 scale-95"
        x-transition:enter-end="transform opacity-100 scale-100"
        x-transition:leave="transition ease-in duration-300"
        x-transition:leave-start="transform opacity-100 scale-100"
        x-transition:leave-end="transform opacity-0 scale-95"
        class={"right-0 py-2 mt-1 #{@dropdown_color} shadow lg:absolute flex flex-col z-10"}
      >
        <ul class="space-y-2 lg:w-48">
          <%= render_slot(@inner_block) %>
        </ul>
      </div>
    </li>
    """
  end

  attr :navigate, :string, default: "/"
  attr :title, :string, default: "Dropdown Item"
  attr :class, :string, default: "text-gray-600 hover:bg-brand-2"
  def dropdown_item(assigns) do
    ~H"""
    <li>
      <.link
        navigate={@navigate}
        x-on:click="function handleClick(e) {
          width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
          dropdownOpen = !dropdownOpen
          if (width <= 1023) {
            navbarOpen = !navbarOpen
          }
        }"
        class={"flex p-2 font-medium #{@class}"}
      >
        <%= @title %>
      </.link>
    </li>
    """
  end

  attr :title, :string, default: "Dropdown Item"
  attr :class, :string, default: "text-white hover:bg-brand-2"
  attr :dropdown_class, :string, default: "bg-gray-900"

  slot :inner_block, required: true
  def nexted_dropdown(assigns) do
    ~H"""
    <li x-data="{nextDropdownOpen: false}">
      <button
        type="button"
        x-on:click="nextDropdownOpen = !nextDropdownOpen"
        class={"flex p-2 w-full font-medium #{@class}"}
      >
        <%= @title %>
        <svg x-bind:class="{ '-rotate-180' : nextDropdownOpen==true }" class="relative top-[1px] -mr-1 h-5 w-5 text-gray-400 ease-out duration-300" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="6 9 12 15 18 9"></polyline></svg>
      </button>
      <div
        x-cloak
        x-show="nextDropdownOpen"
        x-on:click.away="function handleClick(e) {
          width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
          if (width <= 1023) {
            nextDropdownOpen = false
          }
        }"
        @mouseleave="function handleClick(e) {
          width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
          if (width > 1023) {
            nextDropdownOpen = false
          }
        }"
        x-transition:enter="transition ease-out duration-300"
        x-transition:enter-start="transform opacity-0 scale-95"
        x-transition:enter-end="transform opacity-100 scale-100"
        x-transition:leave="transition ease-in duration-300"
        x-transition:leave-start="transform opacity-100 scale-100"
        x-transition:leave-end="transform opacity-0 scale-95"
        class={"right-0 py-2 mt-1 #{@dropdown_color} shadow lg:absolute flex flex-col z-10"}
      >
        <ul class="space-y-2 lg:w-48">
          <%= render_slot(@inner_block) %>
        </ul>
      </div>
    </li>
    """
  end


  attr :navigate, :string, default: "/"
  attr :title, :string, default: "Dropdown Item"
  attr :class, :string, default: "text-white hover:bg-brand-2"
  def nexted_dropdown_item(assigns) do
    ~H"""
    <li>
      <.link
        navigate={@navigate}
        x-on:click="function handleClick(e) {
          width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
          dropdownOpen = !dropdownOpen
          nextDropdownOpen = !nextDropdownOpen
        }"
        class={"w-full flex p-2 font-medium #{@class}"}
      >
        <%= @title %>
      </.link>
    </li>
    """
  end
end
