require 'rails_helper'

RSpec.describe Post, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:comment)).to be_valid
  end
  
  it "内容、User.id がある場合、有効である" do
    user = FactoryBot.create(:user)
    post = Post.new(
      content: "これはテストです",
      user_id: 1
    )
    expect(post).to be_valid
  end

  it "内容がない場合、無効である"
  it "User.idがない場合、無効である"
end
