# frozen_string_literal: true

require_relative '../spec_helper'

describe 'GenericStateMachine::DSL#describe' do
  context 'GSM factory #describe' do
    it 'responds to #describe' do
      expect(GenericStateMachine.respond_to?(:describe)).to be_truthy
    end

    it 'creates GSM using #describe with block' do
      gsm = GenericStateMachine.describe do
        :foo
      end

      expect(gsm).to be_a GenericStateMachine::StateMachine
    end

    it 'throws DSLError when used #describe w/o block' do
      expect { GenericStateMachine.describe }.to raise_error GenericStateMachine::Errors::DSLError, '#describe needs a block'
    end

    it 'really executes the block' do
      result = false
      GenericStateMachine.describe do
        result = true
      end

      expect(result).to be_truthy
    end
  end

  context 'Transitions' do
    it 'has #transitions' do
      dsl = GenericStateMachine::DSL::StateMachineDSL.new

      expect(dsl.respond_to?(:transitions)).to be_truthy
    end

    it 'accepts required parameters in #transition' do
      expect {
        GenericStateMachine.describe do
          transition from: :state, to: :state
        end
      }.to_not raise_error
    end

    it 'accepts optional parameters in #transition' do
      expect {
        GenericStateMachine.describe do
          transition from: :state, to: :state, condition: true
        end
      }.to_not raise_error
    end

    it 'has one valid transition after adding one' do
      dsl = GenericStateMachine::DSL::StateMachineDSL.new
      dsl.transition from: :state, to: :state

      expect(dsl.transitions.count).to eq 1
      expect(dsl.transitions.first).to be_a GenericStateMachine::DSL::Transition
    end

    it 'added transition has given values' do
      dsl = GenericStateMachine::DSL::StateMachineDSL.new
      dsl.transition from: :from_state, to: :to_state, condition: :some_condition
      transition = dsl.transitions.first

      expect(transition.from).to eq :from_state
      expect(transition.to).to eq :to_state
      expect(transition.condition).to eq :some_condition
    end
  end

  context 'Hooks' do
    it 'has #hooks' do
      dsl = GenericStateMachine::DSL::StateMachineDSL.new

      expect(dsl.respond_to?(:hooks)).to be_truthy
    end

    it 'accepts required parameters in #register' do
      expect {
        GenericStateMachine.describe do
          register hook: :some_hook, handler: :some_func
        end
      }.to_not raise_error
    end

    it 'accepts optional parameters in #register' do
      expect {
        GenericStateMachine.describe do
          register hook: :some_hook, handler: :some_func, condition: :foo_bar
        end
      }.to_not raise_error
    end

    it 'has one valid hook after adding one' do
      dsl = GenericStateMachine::DSL::StateMachineDSL.new
      dsl.register hook: :some_hook, handler: :some_func

      expect(dsl.hooks.count).to eq 1
      expect(dsl.hooks.first).to be_a GenericStateMachine::DSL::Hook
    end
  end
end
