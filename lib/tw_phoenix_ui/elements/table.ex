defmodule TwPhoenixUi.Table do
  use Phoenix.Component
  import Phoenix.HTML.Form
  import Phoenix.HTML
  import TwPhoenixUi.Gettext
  alias TwPhoenixUi.PaginationComponent


  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.sidebar id="users" table_data={[]} params={%{}} live_action={:index} />
  """
  attr :params, :map, required: true
  attr :table_data, :list, required: true
  attr :live_action, :any, required: true
  attr :selected_item, :any, required: true
  def sidebar(assigns) do
    ~H"""
    <div class="flex flex-col w-2/5 border-r-2 overflow-y-auto">
      <form class="border-b-2 py-4 px-2" phx-change="iSearch">
        <input
          type="search"
          class="formkit-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
          value={@params["filter"]["isearch"]} name="isearch" placeholder="Search..."
        />
      </form>
      <%= if !Enum.empty?(@table_data) do %>
        <.sidebar_list table_data={@table_data} live_action={@live_action} selected_item={@selected_item} />
      <% else %>
        <.sidebar_list_empty />
      <% end %>
    </div>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.sidebar_list_empty id="users" />
  """
  def sidebar_list_empty(assigns) do
    ~H"""
    <ul>
      <li>
        <div
          class="border-l-4 border-rose-400 flex flex-row py-4 px-2 items-center border-b-2">
          <div class="w-full">
              <div class="text-lg text-center text-rose-500 font-semibold">No data available</div>
          </div>
        </div>
      </li>
    </ul>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.sidebar_list id="users" />
  """
  attr :table_data, :list, required: true
  attr :live_action, :any, required: true
  attr :selected_item, :any, required: true
  def sidebar_list(assigns) do
    ~H"""
    <ul>
      <%= for james <- @table_data do %>
      <li>
        <div
          class={"#{if @live_action == :show && @selected_item == "#{james.id}", do: "border-l-4 border-blue-400", else: "justify-center"} flex flex-row py-4 px-2 items-center border-b-2"}
          phx-click="view_entry" phx-value-data={james.data} phx-value-id={james.id}
          phx-value-status={"#{james.status}"}
          phx-value-name={"#{james.name}"}
      >
          <div class="w-full">
              <div class="text-lg font-semibold"><%= james.name %></div>
              <span class="text-gray-500">
                <%= james.type %>
              </span>
          </div>
        </div>
      </li>
      <% end %>
    </ul>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.empty_sidebar_data id="users" />
  """
  def empty_sidebar_data(assigns) do
    ~H"""
    <div class="h-screen w-full flex flex-col justify-center items-center">
      <svg class="h-20" fill="#000000" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 60 60" xml:space="preserve">
        <path d="M30,1.5c-16.542,0-30,12.112-30,27c0,5.205,1.647,10.246,4.768,14.604c-0.591,6.537-2.175,11.39-4.475,13.689  c-0.304,0.304-0.38,0.769-0.188,1.153C0.276,58.289,0.625,58.5,1,58.5c0.046,0,0.093-0.003,0.14-0.01  c0.405-0.057,9.813-1.412,16.617-5.338C21.622,54.711,25.738,55.5,30,55.5c16.542,0,30-12.112,30-27S46.542,1.5,30,1.5z"/>
      </svg>
      <div class="bg-[#5561E5] text-white px-2 text-md rounded rotate-12 absolute">
        Click on the options on your left
      </div>
    </div>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.done_sidebar_data id="users" />
  """
  attr :message, :string, required: true
  attr :icon, :string, default: """
    <svg class="h-20" viewBox="-4.73 0 72.44 72.44" xmlns="http://www.w3.org/2000/svg" fill="#00FF00">
      <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
      <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
      <g id="SVGRepo_iconCarrier">
        <g id="Group_11" data-name="Group 11" transform="translate(-482.502 -412.731)">
          <path id="Path_25" data-name="Path 25" d="M533.566,429.163l-25.9,25.9-8.182-8.182" fill="none" stroke="#00FF00" stroke-miterlimit="10" stroke-width="3"></path>
          <g id="Group_9" data-name="Group 9" opacity="0.15">
            <circle id="Ellipse_17" data-name="Ellipse 17" cx="29.992" cy="29.992" r="29.992" transform="translate(484.002 423.686)" fill="none" stroke="#00FF00" stroke-linecap="round" stroke-miterlimit="10" stroke-width="3"></circle>
          </g>
          <g id="Group_10" data-name="Group 10">
            <circle id="Ellipse_18" data-name="Ellipse 18" cx="29.992" cy="29.992" r="29.992" transform="translate(484.002 414.231)" fill="none" stroke="#00FF00" stroke-miterlimit="10" stroke-width="3"></circle>
          </g>
        </g>
      </g>
    </svg>
  """
  def done_sidebar_data(assigns) do
    ~H"""
    <div class="h-screen w-full flex flex-col justify-center items-center">
      <%= raw(@icon) %>
      <div class="bg-[#5561E5] text-white px-2 text-md rounded rotate-12 absolute">
        <%= @message %>
      </div>
    </div>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.sidebar_show id="users" selected_item="james" />
  """
  attr :selected_item, :any, required: true
  attr :selected_info, :any, required: true
  attr :edit_form, :boolean, default: false
  attr :selected_item_name, :any, required: true
  def sidebar_show(assigns) do
    ~H"""
    <div id={"selected_item-#{@selected_item}"}
      class="flex-1 p:2 sm:p-6 flex flex-col h-[90vh]">
      <div class="flex sm:items-center justify-between py-3 border-b-2 border-gray-200">
        <span class="text-gray-700 mr-3"><%= @selected_item_name %></span>
      </div>
      <.sidebar_data_list
        edit_form={@edit_form}
        changeset={@changeset}
        selected_info={@selected_info} />
    </div>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.sidebar_data_list id="users" selected_item="james" selected_info={%{}} />
  """
  attr :changeset, :any, required: true
  attr :selected_info, :any, required: true
  attr :edit_form, :boolean, required: true
  def sidebar_data_list(assigns) do
    ~H"""
    <.form
      :let={f}
      for={@changeset}
      id="messages"
      phx-change="validate_input"
      phx-submit="continue"
    >
      <div class="flex flex-col space-y-4 p-3 overflow-y-auto scrollbar-thumb-blue scrollbar-thumb-rounded scrollbar-track-blue-lighter scrollbar-w-2 scrolling-touch h-full">
        <%= if @selected_info[:full] do %>
        <%= textarea(f, @selected_info.head, cols: "50", rows: "20",
            placeholder: "insert your text here...", class: "form-control border-1 px-4 py-3",
            style: "width: 100%; height: 100%", readonly: @edit_form, class: "mt-2 block min-h-[6rem] w-full rounded-lg border-zinc-300 py-[7px] px-[11px]" <>
              "text-zinc-900 focus:border-zinc-400 focus:outline-none focus:ring-4 focus:ring-zinc-800/5 sm:text-sm sm:leading-6" <>
              "phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400 phx-no-feedback:focus:ring-zinc-800/5" <>
              "border-zinc-300 focus:border-zinc-400 focus:ring-zinc-800/5"
            ) %>
        <% else %>
          <div class="grid md:grid-cols-2 md:gap-6 mt-5">
            <%= for james <- @selected_info do %>
              <div class="relative z-0 w-full group">
                <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for={james.id}>
                  <%= Enum.map(String.split(james.head, "_"), &String.capitalize/1) |> Enum.join(" ") %>
                </label>
                <%= if james.head == "updated_by" do %>
                  <input
                    class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light"
                    value={james.data} id={james.id}  type="text"
                    name={"api_management[#{james.head}]"} readonly>
                <% else %>
                  <%= if james.head == "key" do %>
                    <input
                      class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light"
                      value={james.data} id={james.id} type="password"
                      name={"api_management[#{james.head}]"} readonly={@edit_form}>
                  <% else %>
                    <input
                      class="shadow-sm bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 dark:shadow-sm-light"
                      value={james.data} id={james.id} type="text"
                      name={"api_management[#{james.head}]"} readonly={@edit_form}>
                  <% end %>
                <% end %>
              </div>
            <% end %>
          </div>
        <% end %>
      </div>

      <div class="border-t-2 border-gray-200 px-4 pt-4 mb-2 sm:mb-0">
        <div class="relative flex">
        <div
            class="w-full focus:placeholder-gray-400 pl-12 rounded-md py-3"
          />
          <div class="absolute right-0 items-center inset-y-0 hidden sm:flex">
            <%= if @edit_form do %>
              <button type="button" phx-click="edit"
                class="inline-flex items-center justify-center rounded-lg px-4 py-3 transition duration-500 ease-in-out text-white bg-rose-500 hover:bg-blue-400 focus:outline-none">
                  Edit
              </button>
            <% else %>
              <button type="submit"
                class="inline-flex items-center justify-center rounded-lg px-4 py-3 transition duration-500 ease-in-out text-white bg-blue-500 hover:bg-blue-400 focus:outline-none">
                  Save
              </button>
            <% end %>
          </div>
        </div>
    </div>
    </.form>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.main_table id="users" rows={@users}>
        <:col :let={user} label="id"><%= user.id %></:col>
        <:col :let={user} label="username"><%= user.username %></:col>
      </Table.main_table>
  """
  attr :id, :string, required: true
  attr :rows, :list, required: true
  attr :params, :map, required: true
  attr :row_id, :any, default: nil, doc: "the function for generating the row id"
  attr :data_loader, :boolean, default: false, doc: "the function for generating the row id"
  attr :row_click, :any, default: nil, doc: "the function for handling phx-click on each row"

  attr :row_item, :any,
       default: &Function.identity/1,
       doc: "the function for mapping each row before calling the :col and :action slots"

  slot :col, required: true do
    attr :label, :string
  end

  slot :action, doc: "the slot for showing user actions in the last table column"

  def main_table(assigns) do
    assigns =
      assign_new(assigns, :data_loader, fn -> false end)

    ~H"""
    <.iSearch />
    <div class="border rounded-xl shadow-sm dark:bg-gray-100 dark:border-gray-700 shadow ring-1 ring-black ring-opacity-5 sm:rounded-lg">
      <table class="min-w-full divide-y divide-gray-300">
        <thead class="bg-[#379FA7]">
          <tr>
            <th :for={col <- @col} class="px-3 border-b-2 border-brand-700 py-3.5 border-b-brand-700 text-left text-sm text-white font-semibold text-gray-900 "><%= col[:label] %></th>
            <th :if={@action != []} class="relative border-b-2 border-brand-700 py-3.5 pl-3 pr-4 sm:pr-6 rounded-t-md"><span class="sr-only"><%= gettext("Actions") %></span></th>
          </tr>
        </thead>
        <tbody
          id={"#{@id}-tbody"}
          class="divide-y divide-gray-200 bg-white"
        >
          <tr :for={{row, rowi} <- Enum.with_index(@rows)} id={@row_id && @row_id.(row)} class={["border-b transition duration-300 ease-in-out hover:bg-neutral-100", :math.fmod(rowi, 2) == 0.0 && "bg-neutral-50"]}>
            <td
              :for={{col, _i} <- Enum.with_index(@col)}
              phx-click={@row_click && @row_click.(row)}
              class={["whitespace-nowrap px-3 py-4 text-sm text-gray-500", @row_click && "hover:cursor-pointer"]}
            >
              <%= render_slot(col, @row_item.(row)) %>
            </td>
            <td :if={@action != []} class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
              <%= render_slot(@action, @row_item.(row)) %>
            </td>
          </tr>
        </tbody>
        <.empty_table data_loader={@data_loader} data={@rows} />
      </table>
      <.live_component module={PaginationComponent} id="PaginationComponentT4" params={@params}
                    pagination_data={@rows} />
    </div>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.iSearch id="users" params={[]}>
  """
  attr :params, :map, default: %{"filter" => %{"isearch" => ""}}
  def iSearch(assigns) do
    ~H"""
      <form class="max-w-sm" phx-change="iSearch">
        <div class="pb-2 relative formkit-field">
          <label for="member_email" class="hidden block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Email address</label>
          <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-gray-300">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          </div>
          <input
            type="search" name="isearch"
            value={@params["filter"]["isearch"]}  placeholder="Search..."
            class="formkit-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
            aria-describedby="basic-addon3"
          >
        </div>
      </form>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.empty_table id="users" data_loader={false}>
  """
  attr :data, :list, required: true
  attr :data_loader, :boolean, default: false
  defp empty_table(assigns) do
    ~H"""
      <tr style="text-align: center">
        <%= if @data_loader do %>
            <td valign="top" colspan="20" class="text-center">
                <div class="text-center">
                    <div role="status">
                        <svg aria-hidden="true" class="inline w-8 h-8 mr-2 text-gray-200 animate-spin dark:text-gray-600 fill-blue-600" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/>
                            <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentFill"/>
                        </svg>
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>
            </td>
        <% else %>
            <%= if Enum.empty?(@data) do %>
              <td valign="top" colspan="20" class="text-rose-500 p-3">No data available in table</td>
            <% end %>
        <% end %>
      </tr>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.table_status id="users"  status="1" />
  """
  attr :status, :any, required: true
  def table_status(assigns) do
    ~H"""
    <%= if is_integer(@status) do %>
      <.table_numeric_status status={@status} />
    <% end %>
    <%= if is_boolean(@status) do %>
      <.table_boolean_status status={@status} />
    <% end %>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.table_numeric_status id="users" />
  """
  attr :status, :integer, default: 1
  def table_numeric_status(assigns) do
    ~H"""
      <div>
        <%= if @status == 1 do %>
          <span class="bg-brand-2 text-white text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-brand-2 dark:text-white"> Active </span>
        <% end %>
        <%= if @status == 0 do %>
          <span class="bg-red-100 text-red-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300"> Disabled </span>
        <% end %>
        <%= if @status == 3 do %>
            <span class="bg-gray-100 text-gray-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-gray-700 dark:text-gray-300"> Inactive </span>
        <% end %>
        <%= if @status == 4 do %>
            <span class="bg-red-100 text-red-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300"> Pending approval </span>
        <% end %>
        <%= if @status > 4 do %>
            <span class="bg-red-100 text-red-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300"> Unknown </span>
        <% end %>
      </div>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.table_status id="users" />
  """
  attr :status, :boolean, default: true
  def table_boolean_status(assigns) do
    ~H"""
      <div>
        <%= if @status == true do %>
          <span class="bg-brand-2 text-white text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-brand-2 dark:text-white"> Active </span>
        <% end %>
        <%= if @status == false do %>
          <span class="bg-red-100 text-red-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300"> Disabled </span>
        <% end %>
        <%= if @status not in [true, false] do %>
            <span class="bg-red-100 text-red-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300"> Unknown </span>
        <% end %>
      </div>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <Table.extract id="users" rows={@users}>
        <:col :let={user} label="id"><%= user.id %></:col>
        <:col :let={user} label="username"><%= user.username %></:col>
      </Table.main_table>
  """
  attr :id, :string, required: true
  attr :rows, :list, required: true
  attr :record_title, :string, default: ""
  attr :row_id, :any, default: nil, doc: "the function for generating the row id"
  attr :row_click, :any, default: nil, doc: "the function for handling phx-click on each row"

  attr :row_item, :any,
       default: &Function.identity/1,
       doc: "the function for mapping each row before calling the :col and :action slots"

  slot :col, required: true do
    attr :label, :string
    attr :class, :string
  end

  slot :description, doc: "the slot for showing user actions in the last table column"

  def extract(assigns) do
    ~H"""
    <div class="border rounded-xl shadow-sm dark:bg-gray-800 dark:border-gray-700 shadow ring-1 ring-black ring-opacity-5 sm:rounded-lg">
      <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <caption class="p-5 text-lg font-semibold text-left text-gray-900 bg-white dark:text-white dark:bg-gray-800">
          <%= @record_title %>
        </caption>
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th :for={col <- @col} scope="col" class="px-6 py-3"><%= col[:label] %></th>
            <th :if={@description != []} scope="col" class="relative border-b-2 border-brand-700 py-3.5 pl-3 pr-4 sm:pr-6 rounded-t-md"><%= gettext("Description") %></th>
          </tr>
        </thead>
        <tbody
          id={"#{@id}-tbody"}
          class="divide-y divide-gray-200 bg-white"
        >
          <tr :for={{row, rowi} <- Enum.with_index(@rows)} id={@row_id && @row_id.(row)} class={["border-b transition duration-300 ease-in-out hover:bg-neutral-100", :math.fmod(rowi, 2) == 0.0 && "bg-neutral-50"]}>
            <td
              :for={{col, _i} <- Enum.with_index(@col)}
                class={["dark:bg-gray-800 dark:border-gray-700 whitespace-nowrap px-3 py-4 text-sm text-gray-500 #{col[:class]}", @row_click && "hover:cursor-pointer"]}
            >
              <%= render_slot(col, @row_item.(row)) %>
            </td>
            <td :if={@description != []} class="dark:bg-gray-800 dark:border-gray-700 relative whitespace-nowrap py-4 pl-3 pr-4 font-medium sm:pr-6">
              <%= render_slot(@description, @row_item.(row)) %>
            </td>
          </tr>
        </tbody>
        <.empty_table data_loader={false} data={@rows} />
      </table>
    </div>
    """
  end
end
