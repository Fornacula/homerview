# frozen_string_literal: true

class InvitationsController < ApplicationController

  def create; end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :share)
  end
end
