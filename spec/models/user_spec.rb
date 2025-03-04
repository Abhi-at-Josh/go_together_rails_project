require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    context 'ensures name presence' do
      it 'should be invalid without a first name' do
        user = User.new(email: 'sample@gmail.com', first_name: nil)
        expect(user.valid?).to eq(false)
      end

      it 'should be valid with a first name' do
        user = User.new(email: 'sample@gmail.com', first_name: 'John')
        expect(user.valid?).to eq(true)
      end
    end
  end
end
