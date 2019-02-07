# sinatra-pet-management-system
 

##Description

There will be owners and pets in this system. Owners have two types, as normal owner or shelter owner. Only 'shelter' type of owner could delete each pet data from the database. All owners would have access to see owner's list and are able to adopt new dog, and existing dogs from shelters. They also can edit their dog's name. Normal owners only can leave their pets to shelters, and are not able to delete their pets.

##Install instructions

`bundle install`

This command is for installing all the relevant gem with this application.

Next, type this command on the terminal for setting up the database.

`rake db:migrate`
`rake db:seed`

When you type rake db:seed, it will add the 'heaven_shelter' for all pets, as the final destination.

After setting up the database, use 'shotgun' to run the application on the server.

##Contributors

From the former group pjoject, sinata-fwitter-group-project-v-000

`https://github.com/Joeycho/sinatra-fwitter-group-project-v-000/blob/wip/app/controllers/tweets_controller.rb`

Other sources are following,

playlister-sinatra: flash gem for alerting error message interactively.

`https://github.com/Joeycho/sinatra-fwitter-group-project-v-000/blob/wip/app/controllers/tweets_controller.rb`

nyc-sinatra: to fix file structures including sub-directory.

`https://github.com/learn-co-curriculum/nyc-sinatra/tree/solution/app`
