# frozen_string_literal: true

module GenericStateMachine
  module Errors
    # Basic error class
    class GenericStateMachineError < StandardError; end
    # DSLError indicates problems when using the DSL
    class DSLError < GenericStateMachineError; end
    # StateError indicates problems assigning a state
    class StateError < GenericStateMachineError; end
    # HookError indicates problems using a hook
    class HookError < GenericStateMachineError; end
  end
end
