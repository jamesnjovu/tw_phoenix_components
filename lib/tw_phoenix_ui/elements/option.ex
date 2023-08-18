defmodule TwPhoenixUi.Option do
  use Phoenix.Component

  slot :inner_block, required: true
  def bordered(assigns) do
    ~H"""
    <div x-data="{
        optionMenuOpen: false,
        optionMenuCloseDelay: 200,
        optionMenuCloseTimeout: null,
        optionMenuLeave() {
            let that = this;
            this.optionMenuCloseTimeout = setTimeout(() => {
                that.optionMenuClose();
            }, this.optionMenuCloseDelay);
        },
        optionMenuClose() {
            this.optionMenuOpen = false;
        }
      }"
      class="relative inline-block text-left">
      <div>
        <button
          @click="optionMenuOpen = ! optionMenuOpen;"
          @keydown.escape.window="optionMenuLeave()" type="button"
          class="inline-flex w-full justify-center gap-x-1.5 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50"
          id="menu-button" aria-expanded="true" aria-haspopup="true">
          Options
          <svg x-bind:class="{ '-rotate-180' : optionMenuOpen==true }" class="relative top-[1px] ml-1 h-3 w-3 ease-out duration-300" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="6 9 12 15 18 9"></polyline></svg>
        </button>
      </div>
      <div
        x-cloak
        x-ref="optionDropdown"
        x-show="optionMenuOpen"
        @click.outside="optionMenuLeave()"
        x-transition:enter="transition ease-out duration-300"
        x-transition:enter-start="transform opacity-0 scale-95"
        x-transition:enter-end="transform opacity-100 scale-100"
        x-transition:leave="transition ease-in duration-300"
        x-transition:leave-start="transform opacity-100 scale-100"
        x-transition:leave-end="transform opacity-0 scale-95"
        class="absolute right-0 z-30 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
        role="menu" aria-orientation="vertical" aria-labelledby="menu-button"
        tabindex="-1">
        <div class="py-1" role="none">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  attr :title, :string, required: true
  slot :inner_block, required: true
  def accordion(assigns) do
    ~H"""
    <div
        class="rounded-lg border border-neutral-200 bg-white dark:border-neutral-600 dark:bg-neutral-800"
        x-data="{accordion: false}">
        <h2 class="mb-0" id={"heading#{@title}"}>
            <button
                class="group relative flex w-full items-center rounded-t-[15px] border-0 bg-white px-5 py-4 text-left text-base text-neutral-800 transition [overflow-anchor:none] hover:z-[2] focus:z-[3] focus:outline-none dark:bg-neutral-800 dark:text-white [&:not([data-te-collapse-collapsed])]:bg-white [&:not([data-te-collapse-collapsed])]:text-primary [&:not([data-te-collapse-collapsed])]:[box-shadow:inset_0_-1px_0_rgba(229,231,235)] dark:[&:not([data-te-collapse-collapsed])]:bg-neutral-800 dark:[&:not([data-te-collapse-collapsed])]:text-primary-400 dark:[&:not([data-te-collapse-collapsed])]:[box-shadow:inset_0_-1px_0_rgba(75,85,99)]"
                type="button"
                @click="accordion = ! accordion;"
                aria-expanded="true"
                aria-controls="collapseOne">
                <%= @title %>
                <span class="ml-auto h-5 w-5 shrink-0 fill-[#336dec] transition-transform duration-200 ease-in-out group-[[data-te-collapse-collapsed]]:rotate-0 group-[[data-te-collapse-collapsed]]:fill-[#212529] motion-reduce:transition-none dark:fill-blue-300 dark:group-[[data-te-collapse-collapsed]]:fill-white">
                  <svg
                    x-bind:class="{ '-rotate-180' : accordion == true }"
                    class="relative top-[1px] ml-1 h-3 w-3 ease-out duration-300"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24" fill="none"
                    stroke="currentColor" stroke-width="2"
                    stroke-linecap="round" stroke-linejoin="round"
                    aria-hidden="true">
                    <polyline points="6 9 12 15 18 9"></polyline>
                  </svg>
                </span>
            </button>
        </h2>
        <div
            x-cloak
            x-show="accordion"
            x-transition:enter="transform transition ease-in-out duration-500 sm:duration-700"
            x-transition:enter-start="translate-x-full"
            x-transition:enter-end="translate-x-0"
            x-transition:leave="transform transition ease-in-out duration-500 sm:duration-700"
            x-transition:leave-start="translate-x-0"
            x-transition:leave-end="translate-x-full"
            aria-labelledby={@title}>
            <div class="px-5 py-4">
                <%= render_slot(@inner_block) %>
            </div>
        </div>
    </div>
    """
  end
end
