# frozen_string_literal: true

module Hyperui
  class Sidenav < Base
    renders_one :header

    erb_template <<~HTML
      <div class="relative lg:sticky top-0 h-screen flex flex-col justify-between border-e bg-white transition-transform duration-300 lg:transform-none z-50" id="sidenav-container">
        <input type="checkbox" id="sidenav-toggle" class="hidden peer">

        <!-- SideNav -->
        <div class="grow fixed inset-y-0 left-0 w-full sm:w-64 bg-white transform -translate-x-full transition-transform duration-300 peer-checked:translate-x-0 lg:translate-x-0 lg:static lg:transform-none">
          <div class="px-4 py-6 h-full flex flex-col">
            <div class="flex justify-between items-center h-10 mb-2 gap-1 ">
              <div class="flex h-full w-full rounded-lg bg-gray-100 text-gray-600 text-center items-center font-medium align-middle">
                <%= header %>
              </div>

              <label for="sidenav-toggle" class="lg:hidden text-gray-900 p-2 rounded-lg z-50 cursor-pointer h-full hover:bg-gray-100 group">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-5 group-hover:hover:stroke-2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                </svg>
              </label>
            </div>

            <%= content %>
          </div>
        </div>
      </div>
    HTML
  end
end
