# frozen_string_literal: true

##
module GenericStateMachine
  ##
  module DSL
    ##
    # StateMachineDSL provides convenient methods for creating a state machine
    #
    class StateMachineDSL
      attr_reader :transitions, :hooks, :starting

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
        raise GenericStateMachine::Errors::HookError, "Hook '#{hook}' isn't a valid hook" unless
            GenericStateMachine::AVAILABLE_HOOKS.include?(hook)
        raise GenericStateMachine::Errors::HookError, "Can't use value '#{hook}' as hook" if
            hook.nil? || !hook.is_a?(Symbol)

        @hooks ||= []
        @hooks << Hook.new(hook, handler, condition)
      rescue StandardError => e
        raise GenericStateMachine::Errors::DSLError, e
      end

      ##
      # Set the starting state
      # @param [Symbol] from
      # @raise GenericStateMachine::Errors::DSLError on any error
      #
      def start(from:)
        raise GenericStateMachine::Errors::StateError, "Can't use value '#{from}' as state" if
            from.nil? || !from.is_a?(Symbol)

        @starting = from
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