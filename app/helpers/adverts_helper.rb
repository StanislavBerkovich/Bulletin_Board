module AdvertsHelper
  def show_state advert
    state = advert.state.to_sym
    html = "<div class='alert alert-"
    case state
      when :new
        html << "info"
      when :rejected
        html << 'error'
      when :published
        html << 'success'
    end
    html << "'>#{state.capitalize}</div>"
    html.html_safe
  end
end
