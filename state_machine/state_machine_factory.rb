# frozen_string_literal: true

##
module GenericStateMachine
  ##
  # Factory class creating StateMachine instances
  #
  class StateMachineFactory
    class << self
      ##
      # Create a StateMachine instance
      # @param [Symbol] start The starting state
      # @param [Array] transitions All available transitions
      # @param [Array] hooks Optional collection of hooks
      # @raise GenericStateMachine::Errors::GenericStateMachineError
      #
      def create(start:, transitions:, hooks: [])
        raise GenericStateMachine::Errors::GenericStateMachineError, "Can't create state machine w/o starting state" if
            start.nil? || !start.is_a?(Symbol)
        raise GenericStateMachine::Errors::GenericStateMachineError, "Can't create state machine w/o transitions" unless
            transitions.is_a?(Array)
        raise GenericStateMachine::Errors::GenericStateMachineError, "Can't create state machine w/o transitions" if
            transitions.empty?

        _validate_transitions transitions
        _validate_start_state start, transitions
        _validate_hooks(hooks) unless hooks.nil?

        GenericStateMachine::StateMachine.new start
      end

      private

      ##
      # Helper method validating if given start state has a transition
      # raise GenericStateMachine::Errors::GenericStateMachineError if no transition is found
      #
      def _validate_start_state(start, transitions)
        valid = false

        transitions.each do |t|
          if t.from == start
            valid = true
            break
          end
        end

        raise GenericStateMachine::Errors::GenericStateMachineError, "State '#{start}' isn't a valid start state" unless
            valid
      end

      ##
      # Helper method validating if all elements are transitions
      # @param [Array] transitions Array of transitions to be validated
      # raise GenericStateMachine::Errors::GenericStateMachineError if one of the elements is no Transition instance
      #
      def _validate_transitions(transitions)
        raise GenericStateMachine::Errors::GenericStateMachineError, "Transitions can't be empty" if
          transitions.empty?

        transitions.each do |t|
          raise GenericStateMachine::Errors::GenericStateMachineError, "Element '#{t}' isn't a transition" unless
              t.is_a?(GenericStateMachine::Transition)
        end
      end

      ##
      # Helper method validating if all elements are hooks
      # raise GenericStateMachine::Errors::GenericStateMachineError if one of the elements is no Hook instance
      #
      def _validate_hooks(hooks)
        hooks&.each do |t|
          raise GenericStateMachine::Errors::GenericStateMachineError, "Element '#{t}' isn't a hook" unless
              t.is_a?(GenericStateMachine::Hook)
        end
      end
    end
  end
end
