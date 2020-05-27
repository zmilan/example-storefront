<template>
  <div class="mt-12">
    <div class="flex">
      <div>
        <img :src="product.assets.data[0].transforms.data[0].url">
      </div>
      <div class="px-12">
        <h1 class="mb-8 text-3xl">
          {{ product.name }}
        </h1>
        <p>{{ product.description }}</p>
      </div>
      <div class="w-1/3">
        <span class="text-3xl">
          {{ $currency(price, false) }}
          <span class="text-xs text-gray-600">
            <span v-if="showTax">(incl. tax)</span>
            <span v-else>(excl. tax)</span>
          </span>
        </span>
        <div class="my-4">
          <label for="firstName" class="block text-sm font-medium leading-5 text-gray-700">Quantity</label>
          <div class="mt-1 relative rounded-md shadow-sm">
            <input id="firstName" v-model="quantity" class="form-input block w-full sm:text-sm sm:leading-5">
          </div>
        </div>
        <add-to-basket :variant-id="variant.id" :quantity="quantity" />
      </div>
    </div>
  </div>
</template>

<script>
import AddToBasket from '~/components/AddToBasket.vue'

export default {
  components: {
    AddToBasket
  },
  async asyncData ({ app, params, error }) {
    try {
      const route = await app.$getcandy.on('Routes').getRoutesSlug(params.slug, {
        include: 'element'
      })
      if (route.data.type !== 'product') {
        error({
          statusCode: 404
        })
      }
      const product = await app.$getcandy.on('Products').getProductsProductId(route.data.element.data.id, {
        include: 'firstVariant,assets.transforms'
      })
      return {
        product: product.data
      }
    } catch (error) {
      error({
        statusCode: 404
      })
    }
  },
  data () {
    return {
      quantity: 1
    }
  },
  computed: {
    variant () {
      return this.product.first_variant.data
    },
    showTax () {
      return this.$store.state.showTax
    },
    price () {
      if (this.showTax) {
        return this.variant.price + this.variant.total_tax
      }
      return this.variant.price
    }
  },
  methods: {
    changePage (page) {
      this.page = page
      this.search()
    },
    async search () {
      this.products = await this.$getcandy.on('Search').getSearch({
        include: 'first_variant,thumbnail',
        page: this.page,
        per_page: 3,
        keywords: this.keywords
      })
    }
  }
}
</script>
