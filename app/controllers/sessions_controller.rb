class SessionsController < ApplicationController
    def create
      @user = User
              .find_by(email: params["email"])
              .try(:authenticate, params["password"])
      
      if @user
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
      session[:user_id] = @user.id
        render json: {
          token: token,
          time: time,
          status: :created,
          logged_in: true,
          user: @user
        }, methods: [:user_image_url]
      else
        render json: { status: 401 }
      end 
    end
    

    def logout
        reset_session
                render json:{status:200,logged_out:true}
        


    end
    def create_mail
      user = User.find_by_email(params[:email].downcase)
      if user && user.authenticate(params[:password])
      if user.email_confirmed
          sign_in user
        redirect_back_or user
      else
        flash.now[:error] = 'Please activate your account by following the 
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end
      else
        flash.now[:error] = 'Invalid email/password combination' # Not quite right!
        render 'new'
      end
  end
end