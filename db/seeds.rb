# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveStorage::AnalyzeJob.queue_adapter = :inline
ActiveStorage::PurgeJob.queue_adapter = :inline


# 追加
# 管理者
Admin.create!(
  email: 'adomin@portfolio.com',
  password: '111-111'
)

# タグ種類
tags = Tag.create!(
  [
    { tag_type: "ヴィーガン対応" },
    { tag_type: "フルータリアン対応" },
    { tag_type: "ハラル対応" },
    { tag_type: "アレルギー対応可能" },
    { tag_type: "オリエンタル・ベジタリアン対応" },
    { tag_type: "ラクト・ベジタリアン対応" },
    { tag_type: "オボ・ベジタリアン対応" },
    { tag_type: "ラクト・オボベジタリアン対応" },
    { tag_type: "ペスコ・ベジタリアン対応" },
    { tag_type: "ポーヨ・ベジタリアン対応" },
    { tag_type: "フレキシタリアン対応" },
    { tag_type: "マクロビオティック対応" },
    { tag_type: "ローフード対応" },
    { tag_type: "グルテンフリー対応" },
    { tag_type: "相談・交渉可能" },
    { tag_type: "その他" }
  ]
)

# 投稿用会員
end_users = EndUser.create!(
  [
    {email: "olivia@example.com",   nickname: "オリバー",   password: "password"},
    {email: "james@example.com",    nickname: "ジェームス", password: "password"},
    {email: "lucas@example.com",    nickname: "ルーカス",   password: "password"},
    {email: "hitomi@example.com",   nickname: "ひとみ",     password: "password"},
    {email: "sousuke@example.com",  nickname: "そうすけ",   password: "password"},
    {email: "tatuya@example.com",   nickname: "たつや",     password: "password"},
    {email: "kikuo@example.com",    nickname: "きくお",     password: "password"},
    {email: "kisuke@example.com",   nickname: "きすけ",     password: "password"},
    {email: "masahiko@example.com", nickname: "まさひこ",   password: "password"},
    {email: "kaoru@example.com",    nickname: "かおる",     password: "password"},
    {email: "ryukichi@example.com", nickname: "りゅうきち", password: "password"},
    {email: "kanzi@example.com",    nickname: "かんじ",     password: "password"},
    {email: "masahiro@example.com", nickname: "まさひろ",   password: "password"},
    {email: "kaoruko@example.com",  nickname: "かおるこ",   password: "password"}
  ]
)

# 投稿内容
posts = Post.create!(
  [
    {facility_name: "A旅館",       image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1.jpg"), filename:"shop1.jpg"), address: "滋賀県", detailed_description: "スタッフが親切でした。",                      end_user_id: end_users[0].id },
    {facility_name: "Bホテル",     image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2.jpg"), filename:"shop2.jpg"), address: "東京都", detailed_description: "柔軟に対応してくれました。",                  end_user_id: end_users[1].id },
    {facility_name: "Cリゾート",   image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3.jpg"), filename:"shop3.jpg"), address: "北海道", detailed_description: "対応が丁寧でした。" ,                         end_user_id: end_users[2].id },
    {facility_name: "Dカプセル",   image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop4.jpg"), filename:"shop4.jpg"), address: "愛知県", detailed_description: "嫌がらず対応してくれました。" ,               end_user_id: end_users[3].id },
    {facility_name: "Eペンション", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop5.jpg"), filename:"shop5.jpg"), address: "福岡県", detailed_description: "子供達にとても親切にしてくれました。" ,       end_user_id: end_users[4].id },
    {facility_name: "F店",         image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop6.jpg"), filename:"shop6.jpg"), address: "千葉県", detailed_description: "理解ある対応をしてくれました。" ,             end_user_id: end_users[5].id },
    {facility_name: "Gレストラン", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop7.jpg"), filename:"shop7.jpg"), address: "福島県", detailed_description: "ホスピタリティがめっちゃ高かった！" ,         end_user_id: end_users[6].id },
    {facility_name: "H旅館",       image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop8.jpg"), filename:"shop8.jpg"), address: "山梨県", detailed_description: "みんな優しかったです。" ,                     end_user_id: end_users[7].id },
    {facility_name: "Iホテル",     image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop9.jpg"), filename:"shop9.jpg"), address: "京都府", detailed_description: "ぜひ利用して欲しい施設です！。" ,             end_user_id: end_users[8].id },
    {facility_name: "Jリゾート",   image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1.jpg"), filename:"shop1.jpg"), address: "大阪府", detailed_description: "すごくいいところ、また利用したいです。" ,     end_user_id: end_users[9].id },
    {facility_name: "Kカプセル",   image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2.jpg"), filename:"shop2.jpg"), address: "岡山県", detailed_description: "異国料理が楽しめました。" ,                   end_user_id: end_users[10].id },
    {facility_name: "Lペンション", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3.jpg"), filename:"shop3.jpg"), address: "静岡県", detailed_description: "外国人の利用者も多かったです。" ,             end_user_id: end_users[11].id },
    {facility_name: "N店",         image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop4.jpg"), filename:"shop4.jpg"), address: "石川県", detailed_description: "観光に来たなら是非利用して欲しいお店です。" , end_user_id: end_users[12].id },
    {facility_name: "Mレストラン", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop5.jpg"), filename:"shop5.jpg"), address: "群馬県", detailed_description: "こちらの要望を柔軟に受け入れてくれました。" , end_user_id: end_users[13].id }
  ]
)

AssociationPostAndTag.create!(
  [
    { post_id: posts[0].id,  tag_id: tags[0].id },
    { post_id: posts[1].id,  tag_id: tags[1].id },
    { post_id: posts[2].id,  tag_id: tags[2].id },
    { post_id: posts[3].id,  tag_id: tags[3].id },
    { post_id: posts[4].id,  tag_id: tags[4].id },
    { post_id: posts[5].id,  tag_id: tags[5].id },
    { post_id: posts[6].id,  tag_id: tags[6].id },
    { post_id: posts[7].id,  tag_id: tags[7].id },
    { post_id: posts[8].id,  tag_id: tags[8].id },
    { post_id: posts[9].id,  tag_id: tags[9].id },
    { post_id: posts[10].id, tag_id: tags[10].id },
    { post_id: posts[11].id, tag_id: tags[11].id },
    { post_id: posts[12].id, tag_id: tags[12].id },
    { post_id: posts[13].id, tag_id: tags[13].id }
  ]
)