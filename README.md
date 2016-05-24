# Bughouse
This is a templant to get a up and running rails project already intergrated in with Devise and omniauth plugins for 'Facebook', 'Github', 'Twitter', and 'Google', as well as the ability to sign in as a 'Guest'. The content in it is for a bughouse chess application but can easily be removed and edited to your own liking as well as the CSS styles. 


To get a up and running rails application you would need to:

1. pull down this application
2. run bundle install
3. run rake db:migrate
4. create the following ENV variables with their appropriate values:
	* FACEBOOK_APP_ID
	* FACEBOOK_APP_SECRET
	* GOOGLE_APP_ID
	* GOOGLE_APP_SECRET
	* TWITTER_APP_ID
	* TWITTER_APP_SECRET
	* GITHUB_APP_ID
	* GITHUB_APP_SECRET

which are being referenced in the config>initializers>devise.rb file
