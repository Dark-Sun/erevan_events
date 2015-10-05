if Rails.env.development? ||  Rails.env.staging?
  APNS.host = "gateway.sandbox.push.apple.com"
  APNS.pem = "#{Rails.root}/config/apns/dev.pem"
  APNS.pass = "Permanentmotion2015"
else # Prod
  APNS.host = "gateway.push.apple.com"
  APNS.pem = "#{Rails.root}/config/apns/prod.pem"
  APNS.pass = "Permanentmotion2015"

end