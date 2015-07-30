class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Rotten Tomatoes")
  end

  def destroy_email(user)
    @user = user
    mail(to: @user.email, subject: "I see you hate this website, well this webiste hates you too goodbye!")
  end

end
