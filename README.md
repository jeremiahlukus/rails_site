# PantherHackers
## Same site. RoR back-end

### Setup
###### If you are using Windows 10 Home, see the alternate setup below.

- Install Docker from [Docker's website](https://www.docker.com/products/docker).
- Clone this repo from your terminal with `git clone https://github.com/PantherHackers/rails_site.git`.
- Go to project (`cd rails_site`).
- Run `docker-compose run rails bundle exec rake db:create db:migrate` and wait for the containers to build.
- Copy `.env.example` into `.env`. `cp .env.example .env`.
- Fill in the appropriate values in `.env` if you will be using any of the resources (e.g. the Github API).
- If you want to populate the blog posts:
  - Create your own [Github API key](https://github.com/blog/1509-personal-api-tokens) with the `public_repo` permission.
  - Add the token to the `.env` file under `GITHUB_API_KEY`.
  - Run `docker-compose run bundle exec rake posts:import`
- Run `docker-compose up`.
- Wait for the Docker images to start up.
- Go to [localhost:3000](http://localhost:3000).

### Setup for Windows 10 Home
###### Due to Windows 10 Home not having the required technology for Docker for Windows, you will have to use the legacy Docker Toolbox installation instead.

- Install [Docker Toolbox](https://docs.docker.com/toolbox/overview/).
- Open the Docker Quickstart Terminal.
- Get the Docker Machine's IP address using `docker-machine ip`. This will be the IP you will put in the address bar when you start the server.
- Clone the repo from your terminal with `git clone https://github.com/PantherHackers/rails_site.git`.
- Go into the project with `cd rails_site`.
- Copy the contents of the `.env.example` file into a new file named `.env` with `cp .env.example .env`. This will be needed for the next step.
- Run `docker-compose run rails bundle exec rake db:create db:migrate` and wait for the containers to build.
- If you will be changing the `.env` file in order to use any of the resources mentioned in the regular setup above, follow the instructions listed there.
- Start the server with `docker-compose up` and wait for the Docker images to start up.
- Ideally, the server will boot up and start on its own, but this doesn't happen all the time. If it looks like the startup process has stopped, go to IP you got from `docker-machine ip` with your web browser. The server should then spin up and start serving the site.

### Setup for Mac (El Caption)
- Get [homebrew](https://brew.sh/)
- in your terminal paste in (`brew install mysql`)
- Install Docker from [Docker's website](https://www.docker.com/products/docker) and make an account
- Clone this repo from your terminal with (`git clone https://github.com/PantherHackers/rails_site.git`)
- Go to project (`cd rails_site`).
- Run(`docker-compose build`)
- Run (`docker-compose run rails bundle exec rake db:create db:migrate`)
- Run (`docker-compose up`)


### Need to know

- If you change the `Gemfile`, make sure to rebuild the Docker container with `docker-compose build` before running `docker-compose up` again.
- To run commands within a container (to use `rake`, `rails`, or `mysql`), you need to use `docker-compose exec <container> <shell command>`, where `<container>` can be `rails` or `db` depending on whether you want to access the Rails app or the MySQL database.

### Pro-Tips

- In Unix systems, you can setup aliases in your `.bashrc` or `.zshrc` file to help type container commands faster:
  - `alias ddb='docker-compose exec db'`
  - `alias dr='docker-compose exec rails'`
  - `alias dbe='docker-compose exec rails bundle exec'`

### Notes

- Feel free to play with the project, modify files, and refresh the website to see changes.
- If unfamiliar with Rails, check out their [getting started guide](http://guides.rubyonrails.org/getting_started.html).

### Contact
If you have any questions, the instructions in this document are not clear, or the setup does not work for you, feel free to contact Luis on Slack (@luis) or shoot him an email at [luis@pantherhackers.com](mailto:luis@pantherhackers.com)
