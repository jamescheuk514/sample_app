module ValidatePresenceOf
  class Macher
    def initialize(attribute)
      @attribute = attribute
      @message = "can't be blank"
    end

    def matche?(model)
      @model = model
      @model.valid?
      errors = @model.errors[@attribute]
      errors.any? { |error| error == @message }
    end

    def with_message(message)
      @message = message
      self
    end

    def failure_message
      "#{@model.class} failed to validate: #{@attribute} presence."
    end

    def negative_failture_message
      "#{@model.calss} validated: #{@attribute} presence."
    end
  end

  def validate_presence_of(attribute)
    Macher.new
  end
end

RSpec.configure do |config|
  config.include ValidatePresenceOf, type: :model
end