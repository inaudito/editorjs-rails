# editorjs-rails

[Editor.js](https://editorjs.io/) integration for Rails.

Provides some helpers and a little bit of Javascript to integrate the Editor.js block model into a Rails application.

## Installation

Add the `editorjs-rails` gem to your `Gemfile`:

```ruby
gem "editorjs-rails", github: "inaudito/editorjs-rails"
```

Migrate your database:

```sh
rails editorjs:install:migrations
rails db:migrate
```

Mount `Editorjs::Engine` in your `routes.rb`:

```ruby
mount Editorjs::Engine, at: "/editorjs"
```

Add the included script to your application layout:

```erb
<%= javascript_include_tag "editorjs-rails", "data-turbo-track": "reload", defer: true, type: "module" %>
```

## Usage

Add an attribute to your model using `has_text`:

```ruby
class MyModel < ApplicationRecord
  has_text :my_awesome_text
end
```

Then use the `editorjs_text_area` form helper in your views:

```erb
<%= form_with model: @my_model do |form| %>
  <%= form.editorjs_text_area :my_awesome_text %>
<% end %>
```

Use `to_html` to render your content:

```erb
<%= @my_model.my_awesome_text.to_html %>
```

## Adding plugins

First, define `EditorJS.Rails.tools` following the [Editor.js convention](https://editorjs.io/configuration/):

```js
import "@editorjs/paragraph";

EditorJS.Rails = {
  tools: {
    paragraph: Paragraph
  }
};
```

Then register your new block type:

```ruby
class ParagraphBlock < Editorjs::Text::Block
  attr_reader :text

  def initialize(**options)
    super

    @text = @data["text"]
  end

  def to_html
    tag.p(@text.html_safe)
  end
end

Editorjs::Text::Content.register_block_type :paragraph, ParagraphBlock
```

## Included Plugins

| Shorthand | Class | Plugin |
|---|---|---|
| `paragraph` | `Editorjs::Text::Block::Paragraph` | [`@editorjs/paragraph`](https://github.com/editor-js/paragraph) |
| `header` | `Editorjs::Text::Block::Header` | [`@editorjs/header`](https://github.com/editor-js/header) |
| `image` | `Editorjs::Text::Block::Image` | [`@editorjs/image`](https://github.com/editor-js/image) |
| `list` | `Editorjs::Text::Block::List` | [`@editorjs/nested-list`](https://github.com/editor-js/nested-list) |
| `quote` | `Editorjs::Text::Block::Quote` | [`@editorjs/quote`](https://github.com/editor-js/quote) |
| `delimiter` | `Editorjs::Text::Block::Delimiter` | [`@editorjs/delimiter`](https://github.com/editor-js/delimiter) |
