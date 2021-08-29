class ApplicationMailer < ActionMailer::Base
# 　以下の二つに、にメールアドレスを入れる
  default from: 'sample@example.com'
  default to: "sample@example.com"
  layout 'mailer'
end
