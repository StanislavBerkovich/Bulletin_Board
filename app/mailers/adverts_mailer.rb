class AdvertsMailer < ActionMailer::Base
  default from: "stanislav.berkovich.forjob@gmail.com"

  def advert_approve_email(advert)
    @advert = advert
    mail(to: @advert.user.email,
         subject: 'Your advert approved'
    )
  end

  def advert_reject_email(advert)
    @advert = advert
    mail(to: @advert.user.email,
         subject: 'Your advert rejected'
    )
  end
end
