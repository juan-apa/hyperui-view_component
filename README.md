# Hyperui
View Component wrapper for [HyperUI](hyperui.dev)

## Usage
```erb
<%= render Hyperui::Card.new do %>
  Hello, World!
<% end %>
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "hyperui"
```

And then execute:
```bash
$ bundle
```

Import hyperui js in your `app/javascript/application.js`:
```javascript
import "hyperui"
```

Enable eager loading of stimulus controllers in your `app/javascript/controllers/index.js`:
```javascript
import { application } from "controllers/application"

import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
// ...

// add this line
eagerLoadControllersFrom("hyperui/controllers", application)
```

Include the hyperui form builder in your `ApplicationController`:
```ruby
include Hyperui::FormBuilder
```

## Contributing
- Fork the repository
- Clone the repository
- Create a feature branch
- Make your changes
- Open a pull request


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
