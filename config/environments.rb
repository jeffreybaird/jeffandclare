
configure :production, :development do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://jeff@localhost/jeff_and_clare_development')

  ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
end