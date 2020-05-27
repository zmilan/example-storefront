<template>
  <div class="border overflow-hidden rounded shadow">
    <nuxt-link
      :to="{
        name: 'products-slug',
        params: {
          slug: product.routes.data[0].slug
        }
      }"
    >
      <img :src="thumbnail">
    </nuxt-link>
    <div class="p-4 text-center border-t-4 border-gray-200">
      <span class="block text-lg font-light text-gray-600">
        <nuxt-link
          :to="{
            name: 'products-slug',
            params: {
              slug: product.routes.data[0].slug
            }
          }"
        >
          <template v-if="product.attribute_data">
            {{ product.attribute_data.name.webstore.en }}
          </template>
          <template v-else>
            {{ product.name }}
          </template>
        </nuxt-link>
      </span>
      <span class="text-blue-600 text-xl">
        {{ $currency(price, false) }}
        <span class="text-xs text-gray-600">
          <span v-if="showTax">(incl. tax)</span>
          <span v-else>(excl. tax)</span>
        </span>
      </span>
      <div class="mt-2">
        <add-to-basket :variant-id="product.first_variant.data.id" />
      </div>
    </div>
  </div>
</template>

<script>
import AddToBasket from '~/components/AddToBasket.vue'
const first = require('lodash/first')

export default {
  components: {
    AddToBasket
  },
  props: {
    product: {
      type: Object,
      required: true
    }
  },
  computed: {
    showTax () {
      return this.$store.state.showTax
    },
    variant () {
      return this.product.first_variant.data
    },
    price () {
      if (this.showTax) {
        return this.variant.price + this.variant.total_tax
      }
      return this.variant.price
    },
    thumbnail () {
      if (this.product.primary_asset) {
        const transform = first(this.product.primary_asset.data.transforms.data)
        if (transform) {
          return transform.url
        }
        return this.product.primary_asset.url
      } else {
        return this.product.thumbnail.data.thumbnail
      }
    }
  }
}
</script>
