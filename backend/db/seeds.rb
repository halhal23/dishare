10.times do |i|
  User.create({
    name: "test#{i}",
    email: "test#{i}@gmail.com",
    password: 'password',
    password_confirmation: 'password'
  })
end

# Comment.create([
#   {
#     message: "こんにちは！今度ご一緒にどうですか？",
#     user_id: 1,
#     post_id: 4
#   },
#   {
#     message: "halhalさん久しぶり！是非是非！今週の日曜でどう？",
#     user_id: 13,
#     post_id: 4
#   },
#   {
#     message: "ちょっと日程確認してきます！",
#     user_id: 1,
#     post_id: 4
#   },
# ])

Relationship.create([
  {
    user_id: 1,
    follow_id: 2
  },
  {
    user_id: 1,
    follow_id: 3
  },
  {
    user_id: 1,
    follow_id: 4
  },
  {
    user_id: 1,
    follow_id: 5
  },
])