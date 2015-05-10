env_user, env_passwod = ENV['user'], ENV['password']

if env_user && env_passwod
  use Rack::Auth::Basic, 'Restricted Area' do |username, password|
    [username, password] == [env_user, env_passwod]
  end
end

use Rack::Static,
  urls: ['/img', '/js', '/css', '/bower_components'],
  root: '.'

run ->(env) do
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('index.html', File::RDONLY)
  ]
end
