class ApplicationController < ActionController::Base
    include ActionController::Cookies
    before_action :set_csrf_cookie

    def set_csrf_cookie
        if Rails.env == "development"
            cookies["CSRF-TOKEN"] = {
                value: form_authenticity_token
            }
        elsif Rails.env == "production"
            cookies["CSRF-TOKEN"] = {
                value: form_authenticity_token,
                secure: true,
                same_site: :strict,
                domain: 'life-lister.herokuapp.com'
            }
        end
    end
end
