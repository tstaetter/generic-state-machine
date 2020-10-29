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
    it 'can use #transition in block' do
      expect {
        GenericStateMachine.describe do
          transition
        end
      }.to_not raise_error
    end

    pending '#transition accepts parameters'
  end

  context 'Hooks' do
    pending 'Responds to #hook method'
    pending '#hook accepts parameters'
  end
end
