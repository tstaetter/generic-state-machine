# frozen_string_literal: true

require_relative '../spec_helper'

describe GenericStateMachine::StateMachine do
  context 'API' do
    let(:gsm) do
      GenericStateMachine::StateMachine.new :start_state
    end

    it 'has property #current' do
      expect(gsm.respond_to?(:current)).to be_truthy
    end

    it 'has method #next!' do
      expect(gsm.respond_to?(:next!)).to be_truthy
    end

    it 'has method #register' do
      expect(gsm.respond_to?(:register)).to be_truthy
    end

    it 'has method #add' do
      expect(gsm.respond_to?(:add)).to be_truthy
    end
  end

  context 'Transitions' do
    let(:gsm) do
      machine = GenericStateMachine::StateMachine.new :start_state
      machine.add transition: GenericStateMachine::Transition.new(:start_state, :end_state)

      machine
    end

    it 'can add transition' do
      expect { gsm }.to_not raise_error
    end

    it "can't add invalid transition" do
      expect { gsm.add transition: 'some value' }.to raise_error GenericStateMachine::Errors::StateMachineError
    end

    it 'next switches current state to ":end_state"' do
      gsm.next!
      expect(gsm.current).to eq :end_state
    end
  end

  context 'Hooks' do
    let(:gsm) do
      GenericStateMachine::StateMachine.new :start_state
    end

    it 'can register a proc as handler' do
      expect {
        gsm.register hook: :before_transition, handler: proc { puts 'BEFORE_TRANSITION called' }
      }.to_not raise_error
    end

    it 'really executes the hook handler' do
      $global_value = 'change me'
      gsm.register hook: :before_transition, handler: proc { $global_value = 'foo bar' }
      # Call private method for testing purposes
      gsm.send :emit!, :before_transition

      expect($global_value).to eq 'foo bar'
    end

    it 'can register an instance method as handler' do
      class Tester
        attr_reader :value
        def initialize; @value = 'change me'; end
        def change_value; @value = 'foo bar'; end
      end

      t = Tester.new
      gsm.register hook: :before_transition, handler: t.method(:change_value)
      # Call private method for testing purposes
      gsm.send :emit!, :before_transition

      expect(t.value).to eq 'foo bar'
    end
  end
end
