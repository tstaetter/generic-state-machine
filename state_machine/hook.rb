# frozen_string_literal: true

##
module GenericStateMachine
  ##
  # Hook represents one state hook
  #
  class Hook
    attr_reader :name, :handler, :condition

    def initialize(name, handler, condition = nil)
      @name = name
      @handler = handler
      @condition = condition
    end
  end
end
