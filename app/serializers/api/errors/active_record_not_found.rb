class Api::Errors::ActiveRecordNotFound
  attr_reader :model, :detail, :message_key

  def initialize error, message: nil
    @model = error.model.underscore
    @detail = error.class.to_s.split("::")[1].underscore
    @message_key = message || :default
    @errors = serialize
  end

  def serialize
    {
      resource: resource,
      code: code,
      message: message
    }
  end

  def to_hash
    {
      success: false,
      errors: serialize
    }
  end

  private
  def message
    I18n.t "params_exception.active_record.record_not_found.message"
  end

  def resource
    I18n.t(
      underscored_resource_name,
      scope: [:api_validation, :resources]
    )
  end

  def code
    I18n.t detail,
      scope: [:api_validation, :codes],
      default: detail
  end

  def underscored_resource_name
    @model.to_s.gsub("::", "").underscore
  end
end

