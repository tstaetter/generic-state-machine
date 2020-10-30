# frozen_string_literal: true

##
module GenericStateMachine
  # List available hooks
  AVAILABLE_HOOKS = %i[before_transition after_transition end_reached].freeze

  class StateMachine; end
end
