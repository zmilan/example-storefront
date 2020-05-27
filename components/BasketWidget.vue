<template>
  <div class="relative">
    <span class="block mb-1 text-gray-500 text-xs">
      Your basket
    </span>
    <button class="inline-flex relative focus:outline-none" @click="showBasketSummary = !showBasketSummary">
      <svg
        class="w-6"
        fill="none"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        stroke="currentColor"
        viewBox="0 0 24 24"
      ><path d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" /></svg>
      <span class="ml-2">
        {{ total }}
      </span>
    </button>
    <div v-show="showBasketSummary" class="absolute z-50 right-0 px-6 py-4 w-86 bg-white shadow-lg border text-sm rounded">
      <template v-if="basket.lines.length">
        <div v-for="line in basket.lines" :key="line.id" class="flex items-center border-b py-4 border-gray-200">
          <span class="w-12 mr-4">
            {{ line.quantity }} x
          </span>
          <span class="w-full">
            {{ line.variant.data.product.data.name }}
            <span class="text-blue-500 block text-xs">{{ line.variant.data.sku }}</span>
          </span>
          <span class="text-gray-600">
            {{ $currency(line.line_total, false) }}
            <button class="text-red-600 text-sm" @click="remove(line.id)">remove</button>
          </span>
        </div>
        <div class="text-right mt-4">
          <p><strong>Sub Total:</strong> {{ subTotal }}</p>
          <p><strong>Tax:</strong> {{ tax }}</p>
          <p><strong>Total:</strong> {{ total }}</p>
        </div>
        <nuxt-link :to="{ name: 'checkout' }" class="bg-orange-600 text-white px-4 w-full py-3 block text-center mt-4 rounded">
          Checkout
        </nuxt-link>
      </template>
      <div v-else class="text-center">
        Your basket is empty
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      showBasketSummary: false
    }
  },
  computed: {
    basket () {
      return this.$store.state.basket
    },
    total () {
      return this.$currency(this.basket.total, false)
    },
    subTotal () {
      return this.$currency(this.basket.subTotal, false)
    },
    tax () {
      return this.$currency(this.basket.taxTotal, false)
    }
  },
  methods: {
    remove (lineId) {
      this.$store.dispatch('basket/removeLine', lineId)
    }
  }
}
</script>
