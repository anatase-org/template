![Tux beside a yellow oven baking cookies](./res/oven.png)

# Custom Image Template

Make your own custom Anatase image! Anatase is designed to be lean and unopinionated, while not needing extension for normal use. But you might want to mess with the image to add your own tools, or toy around.

Anatase is a normal container image you can download from `i.anatase.org/anatase:stable` and then add your own packages. It is based on the latest version of Fedora, so anything you would install or modify on a fedora container you can do here. In this repository, you can find a template containerfile for building your own image.

Anatase also provides a base image (`i.anatase.org/base:stable`) which is the same Anatase you know with gamemode, Nvidia drivers, and everything included, but without KDE. This way, you can add your own Desktop Environment and experiment with tiling managers, Gnome, Cosmic, or anything else. The base image is built with the same tested packages as the main image so it is a perfect environment to become your own distribution builder and learn about containers.

## Using the template
To use this template, select `Use this template`, clone it, or clone this repository:
```bash
git clone https://github.com/anatase-org/template my-anatase
cd my-anatase
```

Then, customize `Containerfile` to your liking. When done, if on an Anatase system, you can run `./update.sh` from the terminal to update to that image and run it again periodically to access the latest versions. Do not run `./update.sh` in Spaces. If your IDE is in a Space, open the folder using a host terminal and run it there.

### On Github actions
A [build.yml](./.github/workflows/build.yml) Github workflow is provided that allows you to go to your fork, select `Actions > Build Custom Image > Run Workflow`. This will build the image and upload it under `ghcr.io/<your-username>/my-anatase`.

Then, you can switch to it with:
```bash
sudo bootc switch ghcr.io/<my-username>/my-anatase
```

Afterwards, the automatic updater will pick it up and handle updates for you, or you can manually do `sudo bootc update`.

You can edit [build.yml](./.github/workflows/build.yml) to switch `my-anatase` to something else, enable build on pushes, and run the workflow on a schedule.

> [!NOTE]
> **Remember:** use `FROM i.anatase.org/base:stable` when you want to use a different Desktop Environment. To extend Anatase, use `FROM i.anatase.org/anatase:stable` 

## Examples

In the [`./examples`](./examples/) folder, you will find Containerfiles for inspiration, such as ones for Gnome and Cosmic. Feel free to experiment and then PR new examples as well!

## Frequently Asked Questions
The base image does not include a "Return to Gamemode" shortcut or autologin
settings in Handheld Daemon as they are KDE specific. You can configure your Desktop Environment to autologin to "Gamemode" instead.

Gnome supports selecting a session only if you have a password set (gear on the bottom right), otherwise it automatically logs in and blocks you from accessing the button. This is a Gnome issue.

Anatase uses kwallet for secret management. When you switch desktop environments you will lose your secrets, such as various logins in browsers and your IDE credentials (VS Code uses it for your Github login). The examples use the new secret manager oo7, but it is not ready for KDE at this time. This means you can switch through them without losing your secrets.

Lightdm (the Greeter used by Cinnamon and XFCE) does not respect the panel rotation reported by the kernel, so the Steam Deck has the login screen rotated 90 degrees (other portrait panels as well). They also do not associate the touchscreen correctly, so rotating the screen breaks the touchscreen. It does not re-initialize properly when exiting gamemode so you will get a black screen (PRs welcome if you fix it). Without a virtual keyboard, you cannot log in on handhelds.

Cosmic's first boot dialog does not scale properly on handhelds, so you will not be able to complete it without an external display.

**You can rebase between desktop environments arbitrarily, without reinstalling, and face minimal issues (other than losing your secrets).** If you face any issues when rebasing back to KDE, you can open an issue in this repository.