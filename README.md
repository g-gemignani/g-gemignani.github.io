# Personal page
This project contains the code to build my personal page website. You can see it in action at the following link: [https://g-gemignani.github.io](https://g-gemignani.github.io/).

## About the page
This **static web page** is created using [*Jekyll*](https://jekyllrb.com/) and the [Creative Theme](http://startbootstrap.com/template-overviews/creative/) from [Start Bootstrap](http://startbootstrap.com). You can see the original template live in action at <https://volny.github.io/creative-theme-jekyll/>.

## Adapt and build this page

As it is mentioned above, this is a static page. This means that all the HTML code needs to be built beforehand in order to be displayed properly on the web browser. 
But don't worry, GitHub will build the code for you every time you push. Nevertheless, pushing every 5 minutes (and cleaning the web browser cache) to see your page, does not sound like a good plan to develop a web page. 
Instead, you can install *Jekyll* to build and publish your page directly on your computer. On *Ubuntu 20.04 or 22.04*, to do so, you can take the following steps:
<a name="deploy_code"></a>
```console
# Clone repo
git clone https://github.com/g-gemignani/g-gemignani.github.io.git
# Rename the repo with your own username
mv g-gemignani.github.io <my_username>.github.io
cd <my_username>.github.io
git remote remove origin
git remote add origin git@github.com:<my_username>/<my_username>.github.io.git 

# Install rubygems and its dependencies
sudo apt install ruby-rubygems ruby-dev
# Install jekyll and its dependencies
sudo gem install bundler jekyll
# Install ruby gems (modules)
sudo bundle install

# Build page code (inside _site directory) and make it available
bundle exec jekyll serve
# => Now browse to http://localhost:4000 to see your page!
```

After getting a local copy of the website, you can now start modifying it:

1. Adapt the pages to your needs. There are many places that you need to modify in order to fully customize this page. However, some good places to star are the follow:
   - Personal information: `_config.yml` and `about.md`
   - Modify the structure of the page (reorder or remove section): `_layouts/front.html`

2. Every time you save a change the static page hosted by *bundle* should regenerate by itself. However if this is not the case, stop the current **bundle** server and start it again (last command from the [Jekyll installation instructions](#deploy_code))

3. Go Online! If your page is ready, push it and follow the instructions on https://pages.github.com/ to publish your page.
