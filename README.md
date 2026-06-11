## Welcome ##
This repo contains the source code for the PhysioData Toolbox documentation. To see the docs, please visit the [site](https://physiodatatoolbox.leidenuniv.nl/).

## Installation ##

 - Install Ruby 2.7.2 (choose 3 when prompted to install MSYS2 and MINGW toolchains).
 - Run VS Code in admin mode and open the physiodatatoolbox/docs folder.
 - In the VS Code PS terminal, run:
   - `gem install bundler` to install the bundler.
   - `bundle install` to `install the bundle`, as defined in the Gemfile.
   - To build and serve the site, run: `bundle exec jekyll serve --livereload`
   - If it crashes, see [this answer on stackoverflow](https://stackoverflow.com/a/53080143).

## Notes ##
If the file tree doesn't load (or other CORS errors appear), run the site from [http://localhost:4000/](http://localhost:4000/) rather than [http://127.0.0.1:4000/](http://127.0.0.1:4000/).
