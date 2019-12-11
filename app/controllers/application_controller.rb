class ApplicationController < ActionController::Base
	#diviseの機能が使われる場合、その前に実行
	before_action :configure_permitted_parameters, if: :devise_controller?

	#ログイン後のページを設定
	def after_sign_in_path_for(resource)
		if current_user
        flash[:notice] = "ログインに成功しました"
		mypage_path(resource)
	    end
	end

	#ログアウト後のページを設定
	def after_sign_out_path_for(resource)
		new_user_session_path
	end

	protected
	#ユーザ登録（sign_up）の際に、ユーザ名（name）のデータ操作を許可
    def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    end

end
