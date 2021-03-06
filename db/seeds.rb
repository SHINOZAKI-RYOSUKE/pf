# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: "User#{n + 1}",
    introduction: "初めまして、これから参考になるアイテムなどを投稿していきたいと思います。test#{n + 1}",
    greeting: "こんにちわ！test#{n + 1}",
    password: "password",
    password_confirmation: "password",
    profile_image: open("./app/assets/images/test_images/#{n + 1}.jpg"),
  )




    3.times do |i|
      Content.create!(
        user_id: n + 1,
        content_image: open("./app/assets/images/test_images/#{i + 1}.jpg"),
        description: "皆さんの素敵なレイアウトを参考に部屋を小さくイノベーションしました！test#{i + 1}",
      )
    end

    
    3.times do |y|
      Comment.create!(
        user_id: n + 1,
        content_id: y + 1,
        comment: "凄くいいですね。参考にします。"
      )
    end
    
    3.times do |x|
      Favorite.create!(
        user_id: n + 1,
        content_id: x + 1,
      )
    end




end