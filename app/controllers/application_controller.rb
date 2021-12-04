class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment this if you want to force users to sign in before any other actions
  before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

  def homepage

    render(template: "/misc/homepage.html.erb")

  end

  def twilio_test

    twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
    twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
    twilio_sending_number = ENV.fetch("TWILIO_SENDING_NUMBER")

    twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    sms_parameters = {

      from: twilio_sending_number,
      to: "+16034996501",
      body: "Test"

    }

    twilio_client.api.messages.create(sms_parameters)

    redirect_to("/", notice: "Text sent")

  end

end
