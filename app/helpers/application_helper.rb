# frozen_string_literal: true

module ApplicationHelper
  def beginning_of_last_month
    (Date.current - 1.month).beginning_of_month
  end

  def end_of_last_month
    (Date.current - 1.month).end_of_month
  end
end
