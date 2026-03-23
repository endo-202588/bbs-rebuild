require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "バリデーション" do

    it "有効な投稿は保存できる" do
      post = build(:post)
      expect(post).to be_valid
    end

    it "titleがないと無効" do
      post = build(:post, title: nil)
      expect(post).to be_invalid
    end

    it "bodyがないと無効" do
      post = build(:post, body: nil)
      expect(post).to be_invalid
    end

    it "userがないと無効" do
      post = build(:post, user: nil)
      expect(post).to be_invalid
    end
  end
end
