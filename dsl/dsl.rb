# frozen_string_literal: true

##
module GenericStateMachine
  ##
  module DSL
    ##
    # Method is used to describe the properties the GSM should have
    # @raise [GenericStateMachine::Errors::DSLError]
    #
    def describe(&block)
      raise GenericStateMachine::Errors::DSLError, '#describe needs a block' unless block_given?

      dsl = StateMachineDSL.create &block

      _create_state_machine dsl
    end

    ##
    # Struct describing a transition
    #
    Transition = Struct.new(:from, :to, :condition)
    ##
    # Struct describing a hook
    #
    Hook = Struct.new(:name, :handler, :condition)

    private

    ##
    # Actually create an instance of StateMachine using a DSL object
    # @param [StateMachineDSL]
    # @raise [GenericStateMachine::Errors::DSLError]
    #
    def _create_state_machine(dsl)
      transitions = dsl.transitions.collect do |t|
        _transition_from_struct t
      end

      hooks = dsl.hooks.collect do |h|
        _hook_from_struct h
      end

      GenericStateMachine::StateMachineFactory.create start: dsl.starting,
                                                      transitions: transitions, hooks: hooks
    end

    ##
    # Helper creating a Transition instance
    # @param [Transition] transition
    #
    def _transition_from_struct(transition)
      GenericStateMachine::Transition.new transition.from, transition.to, transition.condition
    end

    ##
    # Helper creating a Hook instance
    # @param [Hook] hook
    #
    def _hook_from_struct(hook)
      GenericStateMachine::Hook.new hook.name, hook.handler, hook.condition
    end
  end
end

# Make DSL available directly under main module
GenericStateMachine.extend GenericStateMachine::DSL
