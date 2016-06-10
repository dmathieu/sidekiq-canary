class RegularSpecWorker
  include Sidekiq::Worker
  extend Sidekiq::Canary

  def perform
    # no-op
  end
end

class OtherQueueSpecWorker
  include Sidekiq::Worker
  extend Sidekiq::Canary

  sidekiq_options queue: 'critical'

  def perform
    # no-op
  end
end
