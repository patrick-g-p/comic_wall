Fabricator(:comic) do
  title {Faker::Lorem.word}
  issue_number {Faker::Number.between(1, 500)}
  cover_art_url {Faker::Internet.url('wikipedia.com')}
end
