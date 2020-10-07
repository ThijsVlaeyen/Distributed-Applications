# Language switching

We've seen that our templates can render multilingual context with a small effort. Though the user still needs to be able choose his/her language. We'll do this in 3 steps:

* Provide a link / button
* Read the locale
* Remember the locale (cookie)

## Generating a URL with the language specified

There are 3 common ways to configure your locale with a URL link. Those are commonly:

<!-- markdown-link-check-disable -->

* [http://en.example.com/some/path](http://en.example.com/some/path)
* [http://example.com/en/some/path](http://example.com/en/some/path)
* [http://example.com/some/path?locale=en](http://example.com/some/path?locale=en)

<!-- markdown-link-check-enable -->

We'll go for the last one. So in order to provide these links, we'll create 2 buttons (for japanese and english):

```elixir
defmodule I18nWeb.LayoutView do
  use I18nWeb, :view

  def new_locale(conn, locale, language_title) do
    "<a href=\"#{Routes.page_path(conn, :index, locale: locale)}\">#{language_title}</a>" |> raw
  end
end
```

```html
<!-- app.html.eex -->
    <section class="container">
      <nav role="navigation">
        <ul>
          <li><a href="/">HOME</a></li>
          <li><a href="/another_index">ANOTHER INDEX</a></li>
        </ul>
      </nav>
      <ul>
        <li><%= new_locale @conn, :en, "English" %></li>
        <li><%= new_locale @conn, :ja, "Japanese" %></li>
      </ul>
    </section>
```

Firing up your browser results in language buttons that do nothing (for now).

## Reading the language from the URL

Right now we're pointing to a single location in our application to configure our URL. Though it should be configureable on whatever page. That's why we'll write this as a plug:

```elixir
# router.ex
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug I18nWeb.Plugs.Locale
  end
```

```elixir
defmodule I18nWeb.Plugs.Locale do
  import Plug.Conn

  @locales Gettext.known_locales(I18nWeb.Gettext)

  def init(default), do: default

  def call(conn, _options) do
    case fetch_locale_from(conn) do
      nil ->
        conn

      locale ->
        I18nWeb.Gettext |> Gettext.put_locale(locale)
        conn |> put_resp_cookie("locale", locale, max_age: 365 * 24 * 60 * 60)
    end
  end

  defp fetch_locale_from(conn) do
    (conn.params["locale"] || conn.cookies["locale"])
    |> check_locale
  end

  defp check_locale(locale) when locale in @locales, do: locale
  defp check_locale(_), do: nil
end
```

First of all we add the plug to our browser pipeline. This causes every request to pass through that plug. After which, if the language setting is present, will configure this for every request it is processing. This is done with `I18nWeb.Gettext |> Gettext.put_locale(locale)`.

After the locale is found and set for the connection, we add a cookie.

## Closing notes

<!-- markdown-link-check-disable -->

While it seems at first that the language setting can only be done at the index page, feel free to go to [http://localhost:4000/another_index/?locale=ja](http://localhost:4000/another_index/?locale=ja) . This will illustrate that the language could be set at every route.

<!-- markdown-link-check-enable -->

You need to be able to show:

* That the cookie is stored in your browser
* That the set-cookie header is present in your response
