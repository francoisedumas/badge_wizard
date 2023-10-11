# APP_NAME

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
user can chose to modify a picture
login page strange notification when disconnecting(Réussite de la deconnexion.)
check admin vs mainteneur
validation of email in front from Osponso! how does he do this??
