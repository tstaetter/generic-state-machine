# frozen_string_literal: true

require_relative '../spec_helper'

describe 'GenericStateMachine::DSL' do
  context 'helper methods' do
    it 'creates Transition object from struct' do
      t = GenericStateMachine::DSL::Transition.new :from, :to, nil
      o = GenericStateMachine.send :_transition_from_struct, t

      expect(o).to be_a GenericStateMachine::Transition
      expect(o).to_not be_nil
      expect(o.from).to eq :from
      expect(o.to).to eq :to
      expect(o.condition).to be_nil
    end

    it 'creates Hook objects from struct' do
      h = GenericStateMachine::DSL::Hook.new :hook, nil, nil
      o = GenericStateMachine.send :_hook_from_struct, h

      expect(o).to be_a GenericStateMachine::Hook
      expect(o).to_not be_nil
      expect(o.name).to eq :hook
      expect(o.handler).to be_nil
      expect(o.condition).to be_nil
    end

    it 'creates StateMachine from DSL' do
      dsl = GenericStateMachine::DSL::StateMachineDSL.new
      dsl.transition from: :state, to: :state
      dsl.start from: :state
      o = GenericStateMachine.send :_create_state_machine, dsl

      expect(o).to be_a GenericStateMachine::StateMachine
      expect(o).to_not be_nil
      expect(o.current).to eq :state
    end
  end
end
