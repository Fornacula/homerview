# frozen_string_literal: true

class InvitationsController < ApplicationController

  before_action :set_community, only: %i[new create destroy join]
  before_action :set_invitation, only: %i[show destroy join]

  def new
    @invitation = @community.invitations.build
  end

  def create
    user = User.find_by(email: invitation_params[:email])
    @invitation = Invitation.new(invitation_params)
    user.present? && @invitation.user = user
    if @invitation.save
      redirect_to community_path(@invitation.community), notice: t('communities.member_invited')
    else
      redirect_to(
        new_community_invitation_path(@community, @invitation),
        alert: @invitation.errors.full_messages.join(', ')
      )
    end
  end

  def show
    unless @invitation.allowed_to_see?(User.find(current_user.id))
      redirect_to welcome_path, alert: t('general.alerts.restricted')
    end
  end

  def destroy
    if @invitation.destroy
      redirect_to community_path(@community), alert: t('invitations.revoked')
    else
      redirect_to community_path(@community), alert: @invitation.errors.full_messages.join(', ')
    end
  end

  def join
    user = @invitation.user
    partnership = @community.partnerships.build(
      share: @invitation.share,
      user: @invitation.user
    )
    if partnership.save
      @invitation.destroy
      redirect_to user_path(user), notice: t('invitations.joined')
    else
      redirect_to user_path(user), alert: t('invitations.unable_to_join')
    end
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:email, :share, :community_id)
  end
end
