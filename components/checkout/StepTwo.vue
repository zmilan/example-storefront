<template>
  <form @submit.prevent="save">
    <shipping-options
      v-model="shippingPriceId"
      :order-id="order.id"
      @empty="hasShippingOptions = false"
    />
    <div class="text-right mt-6">
      <button class="bg-indigo-600 text-white rounded px-6 py-3 hover:bg-indigo-700">
        Continue to billing &amp; payment
      </button>
    </div>
  </form>
</template>

<script>
import ShippingOptions from '~/components/checkout/ShippingOptions.vue'

export default {
  components: {
    ShippingOptions
  },
  props: {
    order: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      shippingPriceId: null,
      hasShippingOptions: true
    }
  },
  methods: {
    save () {
      this.$emit('save', {
        shippingPriceId: this.shippingPriceId
      })
    }
  }
}
</script>
