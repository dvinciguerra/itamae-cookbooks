# Create Docker image with Itamae

## install itamae

1. Create a new `Gemfile`

```bash
$ bundle init
$ vim Gemfile
```

2. Now open `Gemfile` and put `itamae` as dependency

```
gem "itamae"
```

3. Save, close file and install deps

```bash
$ bundle install --path vendor
```


## itamae init

1. Create a new `itamae` env

```bash
$ bundle exec itamae init test
```

2. Access `test` directory


3. Now open `Gemfile` and add `docker-api` as dependency

```
gem "docker-api"
```

4. Install new dependencies

```bash
$ bundle install --path vendor
```


## itamae generate role

1. Create a new server `role`

```bash
$ bundle exec itamae generate role test_server
```

2. Open `roles/test_server/default.rb` file and import a new cookbook

```ruby
include_recipe '../../cookbooks/vim'
```

3. Save and close file


## itamae generate cookbook


1. Create a new `vim` cookbook

```bash
$ bundle exec itamae generate cookbook vim
```

2. Open `cookbooks/vim/default.rb` file and create the `recipe`

```ruby
execute 'update apt' do
  command 'apt -y update'
end

package 'vim' do
  options '--force-yes'
end
```

3. Save and close file

## itamae docker

Now run the command bellow to create a docker image

```bash
$ bundle exec itamae docker --image=nginx --tag nginx_with_vim roles/test_server/default.rb
```

This command will create a new `docker image` named `nginx_with_vim` using your recipes.


## Credits

https://hawksnowlog.blogspot.com/2018/06/create-docker-image-with-itamae.html
