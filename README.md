# Padlock

Padlock is a simple Command-Line Application, that runs as a Binary, calling the Auth0 API with the _email address_ and _password_ supplied as arguments on execution.

Part **one** of a **three** part series on non-interactive Auth0 clients.  For this part, I've built a simple Elixir app that allows a user to authenticate themselves through a CLI,  and view account details of themselves in a command line environment, utilising the [Resource Owner Password Grant flow with Auth0](https://auth0.com/docs/api-auth/grant/password).


## Running the App

Clone this Repo to your local machine, and run `mix deps.get` to install the app dependencies.

Open up the `lib/padlock/auth.ex` file, and edit the `do_auth()` func to include your Auth0 Credentials:

``` elixir
def do_auth(email, password) do
  body = Poison.encode!(%{"grant_type" => "password", "username" => "#{email}", "password" => "#{password}", "audience" => "[API AUDIENCE]", "scope" => "openid profile", "client_id" => "[CLIENT ID]", "client_secret" => "[CLIENT SECRET]"})

  url = "https://[YOUR_URL].auth0.com/oauth/token"
  headers = [{"Content-type", "application/json"}]
  HTTPoison.post(url, body, headers, [])
end
```

Next, edit the `verify_token()` func to include your Client Secret as the JWT signing secret:

``` elixir
def verify_token(tkn) do
  tkn
  |> token
  |> with_signer(hs256("[CLIENT SECRET]"))
  |> verify
end
```


## Building the Binary

Now that we have our app coded, we can compile it to an executable binary.  Ensure all files are saved, head into the app's root directory and run:

``` bash
mix escript.build
```

This command tells the `escript` protocol in Mix to build a binary.  We now have a binary that we can call, with the email address and password of a registered user as arguments.  **_Before_** you do that, make sure you have actually registered a test user from within the [Auth0 Management Dashboard](https://manage.auth0.com/#/users).  Once you've created a test user, you can execute the binary:

``` bash
./padlock --email email@email.test --password pa55word
```

Providing that the correct login credentials were supplied, the output will look like this:

![Auth0 Non-Interactive Client Output](https://cdn.auth0.com/blog/elixir-cmd/binary-output.png)


## Contributing

1. Fork it ( https://github.com/rbnpercy/padlock/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [rbnpercy](https://github.com/rbnpercy) Robin Percy - creator, maintainer
