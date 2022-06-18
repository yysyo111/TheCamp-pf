# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'syo@test',
   password: 'syotest'
)

# tag検索データ
Tag.create([
   { name: 'テント' },
   { name: '寝具/シュラフ' },
   { name: 'コット/ベッド' },
   { name: 'クーラーボックス' },
   { name: '調理器具' },
   { name: '燃料/着火用具' },
   { name: '食器' },
   { name: 'ランタン' },
   { name: 'イス' },
   { name: 'テーブル' },
   { name: 'その他' }
   ])
   
   
   