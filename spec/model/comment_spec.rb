require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '.asociations' do
    it { should belong_to(:article) }
  end

  describe '.validates' do
    let!(:article) { create(:article) }
    let!(:comment) { create(:comment, article_id: article.id) }

    specify do
      expect(comment).to validate_presence_of(:commenter)
      expect(comment).to validate_presence_of(:body)
    end
  end
end