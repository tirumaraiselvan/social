# Start digging Twitter 

### Setup

1. Install ruby
2. gem install sinatra
3. gem install sidekiq
4. gem install rails #for active_support
5. git clone repo && cd social
6. rackup --------> localhost:9292/sidekiq
7. (In one console) TWITTER_OAUTH="Basic aabbcc" sidekiq -r ./find_tags.rb # https://dev.twitter.com/oauth/application-only
8. (In another console) irb -r ./find-tags.rb -------> DescriptionTagFinder.perform_async("twitter_handle", "search_tag")
