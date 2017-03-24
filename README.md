# Start digging Twitter 

### Setup

1. Install ruby
2. gem install sinatra
3. gem install sidekiq
4. git clone ~repo~ && cd social
5. rackup --------> localhost:9292/sidekiq
6. (In one console) TWITTER_OAUTH="Basic aabbcc" sidekiq -r ./find_tags.rb
7. (In another console) irb -r ./find_tags.rb -------> DescriptionTagFinder.perform_async
