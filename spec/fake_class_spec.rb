# frozen_string_literal: true

require 'models/fake_class'

RSpec.describe FakeClass do
  subject { described_class.new }

  describe '#attributes' do
    subject { described_class.attributes }

    let(:attributes) { %i[one two three] }

    it 'contains the correct attributes' do
      expect(subject).to eq attributes
    end
  end

  describe '#type_of' do
    subject { described_class.type_of(field) }

    context 'when field is :one' do
      let(:field) { :one }

      it 'returns String' do
        expect(subject).to eq [String]
      end
    end

    context 'when field is :two' do
      let(:field) { :two }

      it 'returns Boolean' do
        expect(subject).to eq [Float]
      end
    end

    context 'when field is :three' do
      let(:field) { :three }

      it 'returns Integer' do
        expect(subject).to eq [Integer]
      end
    end
  end

  describe '#matching_type_for' do
    subject { described_class.matching_type_for(name, value) }

    let(:name) { :one }
    let(:value) { 'value' }

    context 'when name is not defined' do
      let(:name) { :four }

      it 'raises an UnknownAttributeName error' do
        expect { subject }.to raise_error(UnknownAttributeName, ':four')
      end
    end

    context 'when value is not defined' do
      let(:value) { nil }

      it 'does not raise an error' do
        expect { subject }.not_to raise_error
      end
    end

    context 'when value is wrong type' do
      let(:value) { 1 }

      it 'raises a TypeError' do
        expect { subject }.to raise_error(TypeError, '1 for :one is the wrong type')
      end
    end

    context 'when value is correct type' do
      it 'does not raise an error' do
        expect { subject }.not_to raise_error
      end
    end
  end

  it 'has accessor methods for attributes defined' do
    expect(subject).to respond_to :one
    expect(subject).to respond_to :two
    expect(subject).to respond_to :three
  end

  it 'uses the supplied default values', :aggregate_failures do
    expect(subject.one).to eq 'one'
    expect(subject.two).to eq 1.2
    expect(subject.three).to eq nil
  end

  describe '#initialize' do
    subject { described_class.new(**params) }

    context 'when the parameters are only defined attributes' do
      let(:params) { { one: 'won', two: 2.2, three: 3 } }

      it 'does not raise an error' do
        expect { subject }.not_to raise_error
      end

      it 'uses the supplied parameters', :aggregate_failures do
        expect(subject.one).to eq 'won'
        expect(subject.two).to eq 2.2
        expect(subject.three).to eq 3
      end
    end

    context 'when the parameters contain an undefined attribute' do
      let(:params) { { one: 'won', two: 2.0, three: 3, four: 4 } }

      it 'raises an UnknownAttributeName error' do
        expect { subject }.to raise_error(UnknownAttributeName, ':four')
      end
    end
  end

  describe '#inspect' do
    subject { described_class.new.inspect }

    it 'returns the correct string' do
      expect(subject).to eq '#<FakeClass one: "one", two: 1.2, three: nil>'
    end
  end

  describe 'setting an attribute' do
    subject { described_class.new }

    before { subject.one = 'test value' }

    it 'returns the correct value' do
      expect(subject.one).to eq 'test value'
    end
  end
end
