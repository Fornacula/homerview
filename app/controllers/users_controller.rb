# frozen_string_literal: true

class UsersController < ApplicationController

  def show
    @invitations = @user.invitations
  end

  def index
    @users = User.all
  end

end
