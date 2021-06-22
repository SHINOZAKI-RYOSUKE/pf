# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  user = User.create!(
    email: "test#{n + 1}@test.com",
    name: "User#{n + 1}",
    introduction: "初めまして、これから参考になるアイテムなどを投稿していきたいと思います。test#{n + 1}",
    greeting: "こんにちわ！test#{n + 1}",
    password: "password",
    password_confirmation: "password",
    profile_image: open("./app/assets/images/#{n + 1}.jpeg"),
  )

    3.times do |i|
      user.contents.create!(
        content_image: File.open("./app/assets/images/#{i + 1}.jpeg"),
        description: "皆さんの素敵なレイアウトを参考に部屋を小さくイノベーションしました！test#{n + 1}",
      )
    end

    # 5.times do |y|
    #   user.content_comments.create!(
    #     user_id: n + 1,
    #     content_id: n + 1,
    #     comment: "凄くいいですね。参考にします。test#{n + 1}"
    #   )
    # end
    
    5.times do |y|
      Comment.create!(
        user_id: n + 1,
        content_id: n + 1,
        comment: "凄くいいですね。参考にします。test#{n + 1}"
      )
    end

    5.times do |x|
      Favorite.create!(
        user_id: n + 1,
        content_id: n + 1,
      )
    end

end