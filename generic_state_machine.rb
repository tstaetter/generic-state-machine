# frozen_string_literal: true

require_relative 'state_machine/errors'
require_relative 'state_machine/transition'
require_relative 'state_machine/state_machine'
require_relative 'state_machine/state_machine_factory'
require_relative 'dsl/state_machine_dsl'
require_relative 'dsl/dsl'

module GenericStateMachine
  VERSION = '0.1.0'
end
