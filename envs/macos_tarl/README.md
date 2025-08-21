# macos_tart

Using tartelet to run macOS self-hosted runners on GitHub Actions.

> see: https://github.com/shapehq/tartelet/wiki/Configuring-Tartelet

## run configuration

1. Run vm with following command
```sh
tart run runner
```

2. clone repository.
3. Run following command to setup macOS.

```sh
cd ~/Downloads
git clone https://github.com/guitarrapc/local-provisioner
cd local-provisioner/envs/macos_tarl
bash ./prerequisites.sh
```

4. Logout and login as runner user (password: `runner`), then setup tools.

```sh
mkdir -p github/guitarrapc
cd github/guitarrapc
git clone https://github.com/guitarrapc/local-provisioner
cd local-provisioner/envs/macos_tarl
bash ./run.sh
```

Copy ssh public key to your GitHub Actions or Organization.

```sh
ssh runner@$(tart ip runner)
cat ~/.ssh/id_rsa.pub
```

5. Shutdown macOS.

## Initial setup

The VM configured with tart command is as follows.

- see how to bring image: https://github.com/orgs/cirruslabs/packages?repo_name=macos-image-templates

```sh
tart clone ghcr.io/cirruslabs/macos-sequoia-xcode:16.3 runner
tart run runner
```

> [!NOTE]
> This image seems failed unfortunately (Image from https://ipsw.me/)
>
> ```
> $ tart create runner --disk-size=120 --from-ipsw=https://updates.cdn-apple.com/2025SummerFCS/fullrestores/093-10809/CFD6DD38-DAF0-40DA-854F-31AAD1294C6F/UniversalMac_15.6.1_24G90_Restore.ipsw
> ```
