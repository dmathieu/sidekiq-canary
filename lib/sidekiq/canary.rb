module Sidekiq
  module Canary
    def get_sidekiq_options
      options = super
      options.merge('queue' => queue(options["queue"]))
    end

    def queue(default)
      use_canary_queue?(default) ? "#{default}_canary" : default
    end

    def use_canary_queue?(default)
      rand(100) < canary_percent(default)
    end

    def canary_percent(default)
      ENV["#{default.upcase}_CANARY_PERCENT"].to_i
    end

  end
end
