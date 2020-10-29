# frozen_string_literal: true

module GenericStateMachine
  module Errors
    # Basic error class
    class GenericStateMachineError < StandardError; end
    # DSLError indicates problems when using the DSL
    class DSLError < GenericStateMachineError; end
    # StateError indicates problems assigning a state
    class StateError < GenericStateMachineError; end
  end
end
