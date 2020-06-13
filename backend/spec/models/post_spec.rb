require 'rails_helper'

RSpec.describe Post, type: :model do
  it "内容を入力すると、入力内容が取得できること" do
    post = Post.new(
            content:  "これはテストです",
    )
    expect(post.content).to eq "これはテストです"
  end
end
