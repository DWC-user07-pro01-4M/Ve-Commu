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

# 会員
30.times do |n|
    EndUser.create!(
      email: "ve-commu#{n + 1}@portfolio.com",
      password: "111-111",
      nickname: "お野菜大好きマン"
    )
end

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