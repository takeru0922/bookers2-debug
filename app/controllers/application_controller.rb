class ApplicationController < ActionController::Base
    #! devise利用の機能を使用する前にconfigure_permitted_parametersを実行
    before_action :configure_permitted_parameters, if: :devise_controller?

    #! 新規登録後
    def after_sign_up_path_for(resource)
        flash[:message] = "Welcome! You have signed up successfully."
        user_path(current_user.id)
    end

    #! ログイン後
    def after_sign_in_path_for(resource)
        flash[:message] = "Signed in successfully."
        user_path(current_user.id)
    end

    def after_sign_out_path_for(resource)
        flash[:message] = "Signed out successfully."
        root_path
    end

    def configure_permitted_parameters

        devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
    end
end
