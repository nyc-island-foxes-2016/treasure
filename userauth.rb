How to implemet UserAuth using OmniAuth

OAuth requests form from fb, returns a form to user, sends the form data to fb,
returns authorization that fb recognizes this user

Steps:

1- enable bcrypt (check)

2- Given user table, columns 'username', 'email', 'provider', 'uid', 'password_digest'

3- User model, has_secure_password, 

4- Example User instance: 'steven', 'stevecass@devbootbamp.com'

5- class SessionsController < ApplicationController

		def create # our own login
			user= User.find_by(email: params[:email], provider: 'SELF')
			if (user && user.authenticate(params[:password]))
				session[user_id] #
				redirect_to '/' #or root_path
			end
			#don't forget else



6- 	create routes: resource :session, only: [:new, :create]
		root = something

7-	make views/sessions/new form

		<%= form_tag session_path %>
			<fieldset>
				<legend>Please log in </legend>
				<%= text_field_tag :email

				<%= text_field_tag :password
				<%= submit ???

8- gem 'omniauth-facebook' in Gemfile (look at github 'omniauth-facebook')

9-	touch config/initializers/omni-fb.rb

10-	copy paste rails.application.confic.middleware.use....... (code from Github)

11-	go to 'developers.facebook.com', register as developer

12- click on MyApps button, make new app, add 'Website', call it whatever, create new fb app user_id
			--ignore JS sample code
			--'skip quickstart'

13-	Go to settings page, grab App ID, App Secret and keep somewhere

		-- go to ~bash/profile and in it do..
		-- export 'FACEBOOK_KEY'=(App ID)
		-- export 'FACEBOOK_SECRET'=(App Secret)

		-- don't have this info on GitHub page

14-	those values should exist in ENV 

15- Go back to fb dev page, click advanced. for "Valid OAuth redirect URIs", put http://localhost:3000/auth/facebook/callback [EXACT] AND/OR https://some-app.heroku.... for production URI

16- Save fb settings

17-	in github, need to say "get '/auth/:provider/callback', to: 'oauth#create'"

18-	in sessions controller,
		def oauth_create

			User.create_or_get_from_oauth(request.env['omniauth.auth'])
			# test-- render .json
			redirect_to	'/' # or root?
		end

19- Make user instance method, 
		def create_or_get_from_oauth(hash)
			existing = User.find_by(provider: hash[:provider], uid: hash[:uid])
			if existing
				return existing 
			else
				user = User.new(provider: hash[:provider], uid: hash[:uid])
				u.password = SecureRandom.hex(32)
				u.username = hash[:info][:name]	
				u.email = hash[:info][:email]
				##make a random secure password that the user will never use because we assume they will always use fb login
				return user
			end
		end

20- IN FB ap page, you can use test user

