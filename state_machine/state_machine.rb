# frozen_string_literal: true

##
module GenericStateMachine
  # List available hooks
  AVAILABLE_HOOKS = %i[before_transition after_transition end_reached].freeze

  ##
  # StateMachine class
  #
  class StateMachine
    attr_reader :current

    ##
    # Create a new state machine
    # @param [Symbol] start_state The starting state
    # @raise GenericStateMachine::Errors::StateMachineError
    #
    def initialize(start_state)
      raise GenericStateMachine::Errors::StateMachineError, "Can't create state machine w/o start state" if
          start_state.nil? || !start_state.is_a?(Symbol)

      initialize_hooks
      @transitions = {}
      @current = start_state
    end

    ##
    # Add transition
    # @param [GenericStateMachine::Transition] transition
    # @raise GenericStateMachine::Errors::StateMachineError
    #
    def add(transition:)
      raise GenericStateMachine::Errors::StateMachineError, "Invalid transition '#{transition}'" if
          transition.nil? || !transition.is_a?(GenericStateMachine::Transition)

      @transitions[transition.from] = transition
    end

    ##
    # Switch current state
    # @raise GenericStateMachine::Errors::StateMachineError
    #
    def next!
      raise GenericStateMachine::Errors::StateMachineError, "No transition found for '#{@current}'" unless
        @transitions.key?(@current)

      # emit :before_transition
      emit! :before_transition
      @current = @transitions[@current].to
      # emit :after_transition
      emit! :after_transition
    end

    ##
    # Register a new hook
    # @param [Symbol] hook
    # @param [Object] handler The handler called when the hook is reached
    # @raise GenericStateMachine::Errors::StateMachineError
    #
    def register(hook:, handler:)
      raise GenericStateMachine::Errors::StateMachineError, "Invalid hook '#{hook}'" unless
          AVAILABLE_HOOKS.include?(hook) || hook.nil? || !hook.is_a?(Symbol)
      raise GenericStateMachine::Errors::StateMachineError, 'Invalid handler' if
          handler.nil?

      @hooks[hook] << handler
    end

    private

    ##
    # Emit hook
    # @param [Symbol] hook The hook to be emitted
    #
    def emit!(hook)
      @hooks[hook].each(&:call)
    end

    ##
    # Initialize hooks hash
    #
    def initialize_hooks
      @hooks = {}

      GenericStateMachine::AVAILABLE_HOOKS.each do |hook|
        @hooks[hook] = []
      end
    end
  end
end
