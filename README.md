# Introduction

`pass-menu` provides a generic interface to password store, that works well with any command that accepts stdin. ie `fzf`, `dmenu`, `rofi` or even `grep`.

<p align="center">
  <img width="700" src="https://user-images.githubusercontent.com/97400310/221186124-b8f67bac-8f3b-479c-b707-911e232fa144.svg">
</p>

### Features

- `pass-menu` can select induvidual key-value pair data.
- Supports copying and typing on both wayland and X11.
- Has support for TOTP codes using `pass-otp`
- Integrates well with other menu commands rather than being bound to one.

# Installation

## Dependencies

- [bash](https://www.gnu.org/software/bash)
- [gawk](https://www.gnu.org/software/gawk)
- [pass](https://git.zx2c4.com/password-store)
- [pass-otp](https://github.com/tadfisher/pass-otp) (optional)
- X11
  - [xclip](https://github.com/astrand/xclip): to copy key-value data
  - [xdotool](https://github.com/jordansissel/xdotool): to type out data
- Wayland
  - [wc-clipboard](https://github.com/bugaevc/wl-clipboard) or [wc-clipboard-rc](https://github.com/YaLTeR/wl-clipboard-rs)
  - [ydotool](https://github.com/ReimuNotMoe/ydotool) or [wtype](https://github.com/atx/wtype)

## Git

```bash
git clone https://github.com/udayvir-singh/pass-menu.git
cd pass-menu

su -c 'make install'
```

You should use `doas make install`, or `sudo make install` if you have it on your system.

# Usage

`pass-menu` accepts password-store files as described in official [docs](https://www.passwordstore.org/#organization):

```yaml
correct horse battery staple
---
Username: udayvir-singh
Email:    never-gonna-give-you-up@rick.com
Recovery: adhas-w2kjh
          lsk1a-sd809
          2eijk-cc03f

otpauth://totp/PassMenu:udayvir-singh?secret=LSDHSALKHCYQVIAPLYZ&issuer=PassMenu

action(Autofill) :type Username :tab :type Password :sleep 0.2 :copy OTP

action(Hello) :exec "echo HELLO!" :notify "Said Hello"
```

You can also use Password key instead of storing password in first line.

```yaml
Username: udayvir-singh
Password: correct horse battery staple
```

## Actions

`pass-menu` can automate most stuff using actions, the syntax goes as follows:

```js
action(<name>) <...actions>
```

#### Actions can be one of:

| Action             | Description                          |
| ------------------ | ------------------------------------ |
| `:tab`             | type out Tab key                     |
| `:type <key>`      | type out `<key>` in store            |
| `:clip <key>`      | copy `<key>` to clipboard            |
| `:sleep {n}`       | wait for {n} amount of seconds       |
| `:exec "string"`   | pass "string" to shell for execution |
| `:notify "string"` | pass "string" to notify-send         |

#### Actions Usage

- Autofilling forms automatically

```js
action(Autofill) :type Username :tab :type Password :sleep 3 :type OTP
```

- Update password data

```js
action(Update) :exec "pass generate <pass_name>" :notify "Successfully Updated Password"
```

- Print out fortune (idk, I am bored)

```js
action(Fortune) :exec "fortune linux"
```

## Examples

`pass-menu` can be called in CLI by

```bash
pass-menu [ --clip | --type | --echo ] -- <menu-cmd>
```

### FZF

```bash
$ pass-menu -- fzf

$ pass-menu --clip --timeout 10 -- fzf
```

### Dmenu

```bash
$ pass-menu -- dmenu

$ pass-menu --type -- dmenu -i -l 15
```

### Grep

```console
$ pass-menu --echo -- grep -E '<pass-name>|<key>'

$ pass-menu --echo -- grep -E 'Git/GitHub|Password'
```

For more information see `pass-menu --help`

# Alternatives

There are 10+ pass with X menu integerations on Y display server, hence reason for creating `pass-menu`. some popular ones are listed below:

- [**pass-tessen**](https://github.com/ayushnix/pass-tessen): inspiration for this plugin, but showed errors with Wayland variables, only works with fzf.
- [**tessen**](https://github.com/ayushnix/tessen): closest to this plugin, but does not work with X11.
- [**rofi-pass**](https://github.com/carnager/rofi-pass): most feature rich (bloated), only works with rofi on X11.
