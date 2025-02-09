class JwtService
  SECRET_KEY = Rails.application.secret_key_base

  def self.encode(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(body) # Optional, for easier key access
  rescue JWT::DecodeError => e
    nil
  end
end
