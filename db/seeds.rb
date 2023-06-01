# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 追加
# 管理者
Admin.create!(
  email: 'adomin@portfolio.com',
  password: '111-111'
)

# 投稿用会員
end_users = EndUser.create!(
  [
    {email: "olivia@example.com", nickname: "Olivia", password: "password"},
    {email: "james@example.com", nickname: "James", password: "password"},
    {email: "lucas@example.com", nickname: "Lucas", password: "password"},
    {email: "hitomi@example.com", nickname: "ひとみ", password: "password"},
    {email: "sousuke@example.com", nickname: "そうすけ", password: "password"},
    {email: "tatuya@example.com", nickname: "たつや", password: "password"},
    {email: "kikuo@example.com", nickname: "きくお", password: "password"},
    {email: "kisuke@example.com", nickname: "きすけ", password: "password"},
    {email: "masahiko@example.com", nickname: "まさひこ", password: "password"},
    {email: "kaoru@example.com", nickname: "かおる", password: "password"},
    {email: "ryukichi@example.com", nickname: "りゅうきち", password: "password"},
    {email: "kanzi@example.com", nickname: "かんじ", password: "password"},
    {email: "masahiro@example.com", nickname: "まさひろ", password: "password"},
    {email: "kaoruko@example.com", nickname: "かおるこ", password: "password"},
  ]
)

# 投稿内容
Post.create!(
  [
    {facility_name: "あるお店１", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop1.png"), filename:"shop1.png"), address: "滋賀県", detailed_description: "スタッフが親切でした。", end_user_id: end_users[0].id, tag_type_id: Tag[0].id },
    {facility_name: "あるお店２", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop2.png"), filename:"shop2.png"), address: "東京都", detailed_description: "柔軟に対応してくれました。", end_user_id: end_users[1].id, tag_type_id: Tag[1].id },
    {facility_name: "あるお店３", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop3.png"), filename:"shop3.png"), address: "北海道", detailed_description: "対応が丁寧でした。" , end_user_id: end_users[2].id, tag_type_id: Tag[2].id },
    {facility_name: "あるお店４", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop4.png"), filename:"shop4.png"), address: "愛知県", detailed_description: "嫌がらず対応してくれました。" , end_user_id: end_users[3].id, tag_type_id: Tag[3].id },
    {facility_name: "あるお店５", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop5.png"), filename:"shop5.png"), address: "福岡県", detailed_description: "子供達にとても親切にしてくれました。" , end_user_id: end_users[4].id, tag_type_id: Tag[4].id },
    {facility_name: "あるお店６", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop6.png"), filename:"shop6.png"), address: "千葉県", detailed_description: "理解ある対応をしてくれました。" , end_user_id: end_users[5].id, tag_type_id: Tag[5].id },
    {facility_name: "あるお店７", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop7.png"), filename:"shop7.png"), address: "福島県", detailed_description: "ホスピタリティがめっちゃ高かった！。" , end_user_id: end_users[6].id, tag_type_id: Tag[6].id },
    {facility_name: "あるお店８", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop8.png"), filename:"shop8.png"), address: "山梨県", detailed_description: "みんな優しかったです。" , end_user_id: end_users[7].id, tag_type_id: Tag[7].id },
    {facility_name: "あるお店９", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop9.png"), filename:"shop9.png"), address: "京都府", detailed_description: "ぜひ利用して欲しい施設です！。" , end_user_id: end_users[8].id, tag_type_id: Tag[8].id },
    {facility_name: "あるお店１０", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop10.png"), filename:"shop10.png"), address: "大阪府", detailed_description: "すごくいいところ、また利用したいです。" , end_user_id: end_users[9].id, tag_type_id: Tag[9].id },
    {facility_name: "あるお店１１", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop11.png"), filename:"shop11.png"), address: "岡山県", detailed_description: "異国料理が楽しめました。" , end_user_id: end_users[10].id, tag_type_id: Tag[10].id },
    {facility_name: "あるお店１２", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop12.png"), filename:"shop12.png"), address: "静岡県", detailed_description: "外国人の利用者も多かったです。" , end_user_id: end_users[11].id, tag_type_id: Tag[11].id },
    {facility_name: "あるお店１３", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop13.png"), filename:"shop13.png"), address: "石川県", detailed_description: "観光に来たなら是非利用して欲しいお店です。" , end_user_id: end_users[12].id, tag_type_id: Tag[12].id },
    {facility_name: "あるお店１４", image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shop14.png"), filename:"shop14.png"), address: "群馬県", detailed_description: "こちらの要望を柔軟に受け入れてくれました。" , end_user_id: end_users[13].id, tag_type_id: Tag[13].id },
  ]
)

# コメント
Comment.create!(
  [
    {}
    ]
  )

# タグ種類
Tag.create([
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
])