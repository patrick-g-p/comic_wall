# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Comic.create!(title: 'The Amazing Spider-Man', issue_number: 121, cover_art_url: 'https://upload.wikimedia.org/wikipedia/en/2/24/Asm121.jpg' )

Comic.create!(title: 'Batman: The Long Halloween', issue_number: 1, cover_art_url: 'https://upload.wikimedia.org/wikipedia/en/5/52/Batman_thelonghalloween.jpg')

Comic.create!(title: 'Superman(vol. 2)', issue_number: 75, cover_art_url: 'https://upload.wikimedia.org/wikipedia/en/1/1b/Superman75.jpg')

Comic.create!(title: 'Harley Quinn', issue_number: 25, cover_art_url: 'http://img3.wikia.nocookie.net/__cb20090107172905/marvel_dc/images/thumb/5/54/Harley_Quinn_Vol_1_25.jpg/300px-Harley_Quinn_Vol_1_25.jpg')

Comic.create!(title: 'The Amazing Spider-Man(vol. 2)', issue_number: 129, cover_art_url: 'http://img1.wikia.nocookie.net/__cb20141108020056/marveldatabase/images/thumb/e/e3/Amazing_Spider-Man_Vol_1_129_002.jpg/300px-Amazing_Spider-Man_Vol_1_129_002.jpg')

Comic.create!(title: 'X-Men(vol. 2)', issue_number: 53, cover_art_url: 'http://img1.wikia.nocookie.net/__cb20060619191040/marveldatabase/images/thumb/9/95/X-Men_Vol_2_53.jpg/300px-X-Men_Vol_2_53.jpg')

Comic.create!(title: 'Iron Man', issue_number: 1, cover_art_url: 'http://img1.wikia.nocookie.net/__cb20051102174308/marveldatabase/images/thumb/3/30/Iron_Man_Vol_1_1.jpg/300px-Iron_Man_Vol_1_1.jpg')
