# Badge Wizard
<img width="1443" alt="Screenshot 2023-10-12 at 17 01 19" src="https://github.com/francoisedumas/badge_wizard/assets/33062224/41ea53b2-db6f-43eb-a07b-6d7338f52a94">


## Setup

### Prerequisites

- Ruby version: RUBY_VERSION
- Rails version: Rails RAILS_VERSION
- Install [Mailcatcher](https://mailcatcher.me/).
- Basic knowledge about [Tailwind CSS](https://tailwindcss.com/docs) (it's the CSS framework on this app)


### Prepare

```
gh repo clone CHANGE_THIS_TO_GITHUB_REPOSITROY
cd APP_NAME
bundle
```

### Credentials

Ask for dev master key.

```
echo CHANGE_THIS_WITH_GIVEN_MASTER_KEY > config/master.key
```

### Setup

```
setup
```

### Serve

```
dev
```

### Backgroundjobs in production

Sidekiq is available at path `/maintenance/sidekiq`

### Mailcatcher issues
Potentially use command `gem install mailcatcher -- --with-cflags="-Wno-error=implicit-function-declaration"`

## TODO
user can chose to modify a picture add text to it
move sign in button to VC
dry the multi-auth process
