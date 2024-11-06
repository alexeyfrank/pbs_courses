module Ba
  class BaseAction
    attr_accessor :attributes

    def call(attributes = {})
      @attributes = attributes.to_hash.with_indifferent_access
      perform
    end

    private

    def perform
      raise NotImplementedError, "Subclasses must implement the call method"
    end
  end
end
