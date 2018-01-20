# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :community
  belongs_to :user

  validates :email, presence: true
  # bug in shoulda-matchers, therefore _id needed:
  validates :email, uniqueness: { scope: :community_id }
  validates :email, format: { with: Devise.email_regexp }
  validates :share, presence: true
  validates :share, inclusion: 0..1
  validate :self_email

  def allowed_to_see?(user)
    (community.master == user || self.user == user) ? true : false
  end

  private

  def self_email
    if (community.members.each.map { |m| m.email }).include? email
      self.errors.add(:email, I18n.t('invitations.errors.email_already_present'))
    end
  end
end
