require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '.associations' do
    it { should have_many(:comments) }
  end

  describe '.validates' do
    let!(:article) { create(:article) }

    specify do
      expect(article).to validate_presence_of(:title)
      expect(article).to validate_presence_of(:body)
      expect(article).to validate_length_of(:body).is_at_least(10)
    end
  end
end
