class User < ApplicationRecord
    before_validation :ensure_session_token

    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6 }, allow_nil: true

    attr_reader :password

    def generate_unique_session_token
        session_token = SecureRandom::urlsafe_base64(16)
        return session_token unless User.exists?(session_token: session_token)
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def reset_session_token
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(password_digest).is_password?(password)
    end
end
