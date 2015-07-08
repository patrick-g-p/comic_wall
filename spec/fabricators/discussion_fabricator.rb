Fabricator(:discussion) do
  title {Faker::Lorem.word}
  body {Faker::Lorem.paragraph}
end
