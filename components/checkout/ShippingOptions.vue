<template>
  <div>
    <div v-if="loading">
      <!-- By Sam Herbert (@sherb), for everyone. More @ http://goo.gl/7AJzbL -->
      <svg width="38" height="38" class="mx-auto" viewBox="0 0 38 38" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <linearGradient id="a" x1="8.042%" y1="0%" x2="65.682%" y2="23.865%">
            <stop stop-color="#000" stop-opacity="0" offset="0%" />
            <stop stop-color="#000" stop-opacity=".631" offset="63.146%" />
            <stop stop-color="#000" offset="100%" />
          </linearGradient>
        </defs>
        <g fill="none" fill-rule="evenodd">
          <g transform="translate(1 1)">
            <path id="Oval-2" d="M36 18c0-9.94-8.06-18-18-18" stroke="url(#a)" stroke-width="2">
              <animateTransform
                attributeName="transform"
                type="rotate"
                from="0 18 18"
                to="360 18 18"
                dur="0.9s"
                repeatCount="indefinite"
              />
            </path>
            <circle fill="currentColor" cx="36" cy="18" r="1">
              <animateTransform
                attributeName="transform"
                type="rotate"
                from="0 18 18"
                to="360 18 18"
                dur="0.9s"
                repeatCount="indefinite"
              />
            </circle>
          </g>
        </g>
      </svg>
    </div>
    <div v-if="prices.length">
      <label v-for="price in prices" :key="price.id" :for="price.id" class="flex items-center border p-4 rounded">
        <input
          :id="price.id"
          name="form-input delivery"
          type="radio"
          class="form-radio h-4 w-4 text-indigo-600 transition duration-150 ease-in-out"
          :value="price.id"
          required
          @input="$emit('input', $event.target.value)"
        >
        <div class="ml-3">
          {{ $currency(price.rate) }}
          <span class="block text-sm leading-5 font-medium text-gray-700">{{ price.method.data.name }}</span>
        </div>
      </label>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    value: {
      type: String,
      default: null
    },
    orderId: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      prices: [],
      loading: true
    }
  },
  mounted () {
    this.fetchPrices()
  },
  methods: {
    async fetchPrices () {
      this.loading = true
      const prices = await this.$getcandy.on('Orders').getOrdersIdShippingMethods(this.orderId)
      this.loading = false
      this.prices = prices.data
      if (!this.prices.length) {
        this.$emit('empty')
      }
    }
  }
}
</script>
