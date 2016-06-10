require 'spec_helper'

describe Sidekiq::Canary do

  before :each do
    RegularSpecWorker.jobs.clear
    OtherQueueSpecWorker.jobs.clear
  end

  it "runs the worker" do
    expect do
      RegularSpecWorker.perform_async
    end.to change(RegularSpecWorker.jobs, :size).by(1)
    expect(RegularSpecWorker.jobs.first["queue"]).to eql("default")
  end

  it "runs the worker on the canary queue" do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("DEFAULT_CANARY_PERCENT").and_return(100)

    expect do
      RegularSpecWorker.perform_async
    end.to change(RegularSpecWorker.jobs, :size).by(1)
    expect(RegularSpecWorker.jobs.first["queue"]).to eql("default_canary")
  end

  it "runs a worker on another queue" do
    expect do
      OtherQueueSpecWorker.perform_async
    end.to change(OtherQueueSpecWorker.jobs, :size).by(1)
    expect(OtherQueueSpecWorker.jobs.first["queue"]).to eql("critical")
  end

  it "runs the worker on the canary queue" do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("CRITICAL_CANARY_PERCENT").and_return(100)

    expect do
      OtherQueueSpecWorker.perform_async
    end.to change(OtherQueueSpecWorker.jobs, :size).by(1)
    expect(OtherQueueSpecWorker.jobs.first["queue"]).to eql("critical_canary")
  end
end
