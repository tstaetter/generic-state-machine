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

      yield block

      GenericStateMachine::StateMachine.new
    end
  end
end

# Make DSL available directly under main module
GenericStateMachine.extend GenericStateMachine::DSL