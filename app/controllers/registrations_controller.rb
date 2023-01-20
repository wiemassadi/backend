class RegistrationsController<ApplicationController
    def create
        user=User.create!(
            email:params['email'],
            password:params['password'],
            password_confirmation:params['password_confirmation'],
            role:params[:role].to_i 
        ) 
        if user 
          
          UserMailer.registration_confirmation(user).deliver
            session[:user_id]=user.id
            render json:{
                user:user
            }
        else
            render json:{status:500}
          
        end
    end
    
  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      redirect_to 'http://localhost:4200'
    end
end
end