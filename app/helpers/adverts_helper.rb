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
    html << "'>#{cap I18n.t("advert.states.#{state}")}"
    if state == :rejected
      html << " #{I18n.t('views.because')} #{advert.reject_reason}"
    end
    html << "</span>"
    html.html_safe
  end
end
