# frozen_string_literal: true

class CommunitiesController < ApplicationController
  def create
    @community = Community.new(community_params)
    partnership = current_user.partnerships.build(
      community: @community,
      share: 1
    )
    if partnership.save
      redirect_to communities_path, notice: t('communities.successful_create')
    else
      redirect_to new_community_path, alert: partnership.errors.full_messages.join(', ')
    end
  end

  def index
    @communities = current_user.communities
  end

  private

  def community_params
    params.require(:community).permit(
      :name, :user
    )
  end
end
