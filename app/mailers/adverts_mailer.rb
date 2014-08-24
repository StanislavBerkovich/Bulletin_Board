class AdvertsMailer < ActionMailer::Base
  default from: "stanislav.berkovich.forjob@gmail.com"

  def advert_change_state(advert, state)
    @advert = advert
    @state = state.to_s
    mail(to: @advert.user.email,
         subject: "Your advert #{state}"
    )
  end
end
