if Rails.env.development? ||  Rails.env.staging?
  APNS.host = "gateway.sandbox.push.apple.com"
  APNS.pem = "#{Rails.root}/config/apns/prod.pem"
  APNS.pass = "Aa123456"
else # Prod
  APNS.host = "gateway.push.apple.com"
  APNS.pem = "#{Rails.root}/config/apns/prod.pem"
  APNS.pass = "Aa123456"

end