# frozen_string_literal: true

class InvitationsController < ApplicationController

  def new
    @community = Community.find_by(params[:id])
    @invitation = @community.invitations.build
  end

  def create
    user = User.find_by(email: invitation_params[:email])
    byebug
    invitation = Invitation.new(invitation_params)
    user.present? && invitation.user = user
    if invitation.save
      redirect_to community_path(invitation.community)
    else
      render :new, alert: "Jama"
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :share, :community_id)
  end
end
