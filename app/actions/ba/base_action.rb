module Ba
  class BaseAction
    include ActiveModel::Validations

    attr_accessor :attributes
    def initialize(attributes = {})
      @attributes = attributes.to_hash.with_indifferent_access
    end

    def call
      raise NotImplementedError, "Subclasses must implement the call method"
    end
  end
end
