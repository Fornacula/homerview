# frozen_string_literal: true

class CommunitiesController < ApplicationController
  before_action :set_community, only: %i[show edit update destroy]

  def create
    @community = Community.new(community_params)
    @community.set_master(current_user)
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

  def show
    @master = @community.master
    @partnerships = @community.partnerships
    @invitations = @community.invitations
  end

  def update
    if @community.update(community_params)
      redirect_to communities_path, notice: t('communities.successful_update')
    else
      redirect_to edit_community_path, alert: @community.errors.full_messages.join(', ')
    end
  end

  def destroy
    if @community.destroy
      redirect_to communities_path, notice: t('communities.successful_destroy')
    else
      redirect_to community_path(@community), alert: @community.errors.full_messages.join(', ')
    end
  end

  def index
    @communities = current_user.all_communities
  end

  private

  def community_params
    params.require(:community).permit(
      :name, :user
    )
  end

  def set_community
    @community = Community.find(params[:id])
  end
end
