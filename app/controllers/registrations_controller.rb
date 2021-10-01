class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
        if resource.persisted?
            render json: {
                status: { code: 200, message: 'Signed up sucessfully' }
            }, status: :ok
        else
            render json: {
                status: { code: 422, errors: "Sign up failed. #{resource.errors.full_messages.to_sentence}" }
            }, status: :unprocessable_entity
        end
    end
end
