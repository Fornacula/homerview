# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  has_many :invoices
  has_many :identities
  has_many :partnerships

  def communities
    Community.where(id: partnerships.pluck(:community_id))
  end

  def facebook
    identities.where(provider: 'facebook').first
  end

  def facebook_client
    @facebook_client ||= Facebook.client(access_token: facebook.accesstoken)
  end

  def google_oauth2
    identities.where(provider: 'google_oauth2').first
  end

  def google_oauth2_client
    unless @google_oauth2_client
      @google_oauth2_client = Google::APIClient.new(
        application_name: 'hOverView',
        application_version: '1.0.0'
      )
      @google_oauth2_client.authorization.update_token!(
        access_token: google_oauth2.accesstoken,
        refresh_token: google_oauth2.refreshtoken
      )
    end
    @google_oauth2_client
  end
end
