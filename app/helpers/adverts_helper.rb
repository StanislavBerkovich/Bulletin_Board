module AdvertsHelper
  def show_state advert
    state = advert.state.to_sym
    html = "<span class='label label"
    case state
      when :new
        html << '-warning'
      when :approved
        html << '-info'

      when :published
        html << '-success'
      when :archives
        html << '-inverse'
      when :rejected
        html << '-important'
    end
    html << "'>#{state.capitalize} #{advert.reject_reason}</span>"
    html.html_safe
  end
end
