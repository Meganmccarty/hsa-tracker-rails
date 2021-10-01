class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    include Devise::JWT::RevocationStrategies::JTIMatcher

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :jwt_authenticatable, jwt_revocation_strategy: self
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true

    has_many :receipt_records, -> { order(trans_date: :desc) }

    def send_password_reset
        self.reset_password_token = generate_base64_token
        self.reset_password_sent_at = Time.zone.now
        save!
        UserMailer.password_reset(self).deliver_now
    end

    def reset_password_token_valid?
        (self.reset_password_sent_at + 1.hour) > Time.zone.now
    end

    def reset_password(password)
        self.reset_password_token = nil
        self.password = password
        save!
    end

    private

    def generate_base64_token
        SecureRandom.urlsafe_base64
    end
end
