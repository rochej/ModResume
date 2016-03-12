class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def asset_types
    @asset_types = ["objectives", "experiences", "projects", "educations", "skills", "volunteerings"]
  end



  def after_sign_in_path_for(resource)
    user_resumes_path(resource)
  end
end
