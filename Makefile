rbm=./rbm/rbm

all: release

release: submodule-update
	$(rbm) build release --target release --target tor-all

release-android-armv7: submodule-update
	$(rbm) build release --target release --target tor-android-armv7

release-linux-x86_64: submodule-update
	$(rbm) build release --target release --target tor-linux-x86_64

release-linux-x86_64-debug: submodule-update
	$(rbm) build release --target release --target tor-linux-x86_64-debug

release-linux-i686: submodule-update
	$(rbm) build release --target release --target tor-linux-i686

release-windows-i686: submodule-update
	$(rbm) build release --target release --target tor-windows-i686

release-windows-x86_64: submodule-update
	$(rbm) build release --target release --target tor-windows-x86_64

release-osx-x86_64: submodule-update
	$(rbm) build release --target release --target tor-osx-x86_64

incrementals-release: submodule-update
	$(rbm) build release --step update_responses_config --target release --target create_unsigned_incrementals
	tools/update-responses/download_missing_versions release
	tools/update-responses/gen_incrementals release
	$(rbm) build release --step hash_incrementals --target release

update_responses-release: submodule-update
	$(rbm) build release --step update_responses_config --target release --target signed
	$(rbm) build release --step create_update_responses_tar --target release --target signed

submodule-update:
	git submodule update --init

fetch: submodule-update
	$(rbm) fetch

clean: submodule-update
	./tools/clean-old

clean-dry-run: submodule-update
	./tools/clean-old --dry-run

