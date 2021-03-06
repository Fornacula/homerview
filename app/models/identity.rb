# frozen_string_literal: true

class Identity < ApplicationRecord
  belongs_to :user

  validates :uid, presence: true
  validates :provider, presence: true

  validates :uid, uniqueness: { scope: :provider }

  def self.find_for_oauth(auth)
    identity = find_by(provider: auth.provider, uid: auth.uid)
    identity = create(uid: auth.uid, provider: auth.provider) if identity.nil?
    identity.accesstoken = auth.credentials.token
    identity.refreshtoken = auth.credentials.refresh_token
    identity.name = auth.info.name
    identity.email = auth.info.email
    identity.nickname = auth.info.nickname
    identity.image = auth.info.image
    identity.phone = auth.info.phone
    identity.urls = (auth.info.urls || '').to_json
    identity.save
    identity
  end
end
