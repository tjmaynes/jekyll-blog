BLOG_DIRECTORY              = $(PWD)
BLOG_PUBLISHING_DIRECTORY   = $(BLOG_DIRECTORY)/public
REPO                        = git@github.com:tjmaynes/blog.git
TARGET_BRANCH               = gh-pages
JEKYLL_VERSION              = 4.1.0

define jekyll_run
docker run --rm \
  --publish 4000:4000 \
  --volume="$(PWD):/srv/jekyll" \
  --volume="$(PWD)/vendor/bundle:/usr/local/bundle" \
  -it jekyll/jekyll:$(JEKYLL_VERSION) \
  jekyll ${1}
endef

define execute_script
chmod +x ./scripts/${1}.sh
./scripts/${1}.sh
endef

install_dependencies:
	$(call execute_script,$@)

.PHONY: build
build:
	$(call jekyll_run,build)

edit:
	$(call jekyll_run,serve --watch --trace)

preview: build 
	$(call execute_script,$@) \
	$(BLOG_PUBLISHING_DIRECTORY)	

deploy:
	$(call execute_script,$@) \
		$(GIT_USERNAME) \
		$(GIT_EMAIL) \
		$(GIT_COMMIT_SHA) \
		$(TARGET_BRANCH) \
		$(BLOG_PUBLISHING_DIRECTORY) \
		$(REPO)

clean:
	rm -rf $(BLOG_PUBLISHING_DIRECTORY)
