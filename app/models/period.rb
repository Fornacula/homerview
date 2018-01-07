# frozen_string_literal: true

class Period < ApplicationRecord
  belongs_to :invoice

  before_save :manage_single_invoice_period

  private

  def manage_single_invoice_period
    self.period_end = nil if single
  end
end
