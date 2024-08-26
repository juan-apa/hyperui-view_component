# frozen_string_literal: true

module Hyperui
  class Skeleton < Base
    erb_template <<-ERB
      <div class="flex flex-col w-full h-full gap-1">
        <div class="flex h-1/3 w-full gap-1">
          <div class="animate-pulse rounded rounded-md w-1/2 bg-black/25"></div>
          <div class="animate-pulse rounded rounded-md w-1/2 bg-black/25"></div>
        </div>
        <div class="h-2/3 w-full flex flex-col justify-between">
          <div class="animate-pulse rounded rounded-md w-full bg-black/25 h-[30%]"></div>
          <div class="animate-pulse rounded rounded-md w-full bg-black/25 h-[30%]"></div>
          <div class="animate-pulse rounded rounded-md w-full bg-black/25 h-[30%]"></div>
        </div>
      </div>
    ERB
  end
end
