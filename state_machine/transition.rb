# frozen_string_literal: true

##
module GenericStateMachine
  ##
  # Transition represents one transition of the state
  #
  class Transition
    attr_reader :from, :to, :condition

    def initialize(from, to, condition = nil)
      @from = from
      @to = to
      @condition = condition
    end
  end
end
