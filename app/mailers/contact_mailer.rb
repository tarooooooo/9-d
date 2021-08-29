class ContactMailer < ApplicationMailer
  # 以下にメールアドレスを入力?
  default from: "@gmail.com"


  def send_when_admin_reply(user, contact) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    @answer = contact.reply_text #返信内容
    mail to: user.email, subject: '【サイト名】 お問い合わせありがとうございます'
  end

  def send_mail(mail_title, mail_content, group_user)
    @mail_title = mail_title
    @mail_content = mail_content
    mail bcc: group_user.pluck(:email), subject: mail_title
  end

end
