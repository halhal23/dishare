# User.create({
#   name: 'halhal',
#   email: 'halhal@gmail.com',
#   password: 'password',
#   password_confirmation: 'password'
# })

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
    follow_id: 13
  },
  {
    user_id: 13,
    follow_id: 1
  },
  {
    user_id: 1,
    follow_id: 2
  },
  {
    user_id: 2,
    follow_id: 1
  },
])