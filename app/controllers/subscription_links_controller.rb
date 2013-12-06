class SubscriptionLinksController < ApplicationController

  def index
    @subscription_links = SubscriptionLink.all
  end
end
