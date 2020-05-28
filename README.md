# Example Nuxt Storefront with SSR (WIP)

> This should not be considered production ready

This repo aims to give you a running start on how to use the Javascript client to create a storefront. It's not designed to be a fully featured store you can just put your logo on, it's here to provide an example of how you can get up and running with the API to create your own store.

Features will be added over time and on request.

## Features

- [x] SSR Support
- [x] List products on homepage
- [x] Search products
- [x] View products by category
- [x] Add products to basket
- [x] Remove products from basket
- [x] Checkout process
  - [x] Shipping address details
  - [x] Shipping method fetching and selecting
  - [x] Billing address
  
> There is no payment process on the checkout, the checkout just makes an offline payment. There are a ton of different ways you can take payment so trying to fit them all on would be quite intense. If you specifically want a method of Payment shown, create a feature issue on this repo and we can discuss.

## Build Setup

```bash
# install dependencies
$ yarn install

# serve with hot reload at localhost:3000
$ yarn dev

# build for production and launch server
$ yarn build
$ yarn start

# generate static project
$ yarn generate
```

For detailed explanation on how things work, check out [Nuxt.js docs](https://nuxtjs.org).

### ENV Config

These variables should go in an `.env` file at the root of the project.

- `API_HOST` - The host for your API

---

This storefront assumes you have the API set up already.

## Database considerations

There are a few considerations to make when using this storefront, for example, you must have adequate shipping pricing, methods, zones etc set up. There will be a `schema.sql` file on the repo you can import into your database to make this easier for you.

# Feature requests, contributing etc...

If you want to see a feature or an explanation on how things work, create an issue on the repo and we can take a look. For contributing, create an issue or PR. Please discuss with us before you go to the hard work of creating a PR, just so we don't waste anyones time with something we feel wouldn't fit on this example.


