# Getting Set Up

1. [Install Jekyll](https://jekyllrb.com/docs/installation)
2. Run `bundle install` to install necessary bundler dependencies
3. Run `npm i` to install necessary tailwind dependencies (only necessary if you are messing with the css)
4. Run `bundle exec jekyll serve --livereload` to test

# If You Need to Change the Styling
If you are messing with any CSS classes, in another tab run
```
$ npx @tailwindcss/cli -i ./assets/css/main.css -o ./assets/css/tailwind.css --watch
```
