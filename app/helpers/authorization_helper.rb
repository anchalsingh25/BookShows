module AuthorizationHelper

  SECRET_KEY = 'AnchalSingh2002'
  EXPIRATION_TIME = 59.minute.to_i

  def self.encode_token(payload)
    payload[:exp] = Time.now.to_i + EXPIRATION_TIME
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decoded_token(auth_header)
    return nil unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end
end
