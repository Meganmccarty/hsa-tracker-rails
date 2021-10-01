class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(_resource, _opts = {})
        if current_user
            render json: {
                user: current_user,
                status: { code: 200, message: 'Logged in successfully' }
            }, status: :ok
        end
    end

    def respond_to_on_destroy
        render json: {
            status: { code: 200, message: 'Logged out successfully' }
        }, status: :ok
    end
end
