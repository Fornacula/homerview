# frozen_string_literal: true

module CommunityHelper
  def percentify(arg)
    "#{(arg * 100).round}%"
  end

  def member_name(p)
    if p.user == p.community.master
      "#{p.user.full_name} (<b>#{t('communities.master')}</b>)".html_safe
    else
      p.user.full_name
    end
  end
end
