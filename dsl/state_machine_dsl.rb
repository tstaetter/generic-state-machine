# frozen_string_literal: true

##
module GenericStateMachine
  ##
  module DSL
    ##
    # StateMachineDSL provides convenient methods for creating a state machine
    #
    class StateMachineDSL
      attr_reader :transitions, :hooks

      ##
      # Add transition
      # @param [Symbol] from The current state
      # @param [Symbol] to The state to transit to
      # @param [Object] condition An optional condition determining whether the transition should be executed
      # @raise [GenericStateMachine::Errors::DSLError] on any error
      #
      def transition(from:, to:, condition: true)
        @transitions ||= []
        @transitions << Transition.new(from, to, condition)
      rescue StandardError => e
        raise GenericStateMachine::Errors::DSLError, e
      end

      ##
      # Add hook
      # @param [Symbol] hook The name of the hook
      # @param [Symbol] handler Name of the handler to be executed
      # @param [Object] condition Optional condition determining whether the hook should be executed
      # @raise [GenericStateMachine::Errors::DSLError] on any error
      #
      def register(hook:, handler:, condition: nil)
        @hooks ||= []
        @hooks << Hook.new(hook, handler, condition)
      rescue StandardError => e
        raise GenericStateMachine::Errors::DSLError, e
      end

      class << self
        ##
        # Factory method creating the DSL helper object
        #
        def create(&block)
          obj = new
          obj.instance_eval(&block)

          obj
        end
      end
    end
  end
end