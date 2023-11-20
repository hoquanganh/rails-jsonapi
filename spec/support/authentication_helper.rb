module AuthenticationHelper
  def login(user)
    set_session_double({ user_id: user.id })
  end

  def logout(_user)
    set_session_double({ user_id: nil })
  end

  def set_session_double(session_hash)
    session_double = instance_double(ActionDispatch::Request::Session, enabled?: true, loaded?: false)

    allow(session_double).to receive(:[]) do |key|
      session_hash[key]
    end

    allow(session_double).to receive(:[]=) do |key, value|
      session_hash[key] = value
    end

    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(session_double)
  end
end

RSpec.configure do |c|
  c.include AuthenticationHelper
end
