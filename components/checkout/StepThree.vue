<template>
  <form @submit.prevent="save">
    <checkout-address v-model="value" />
    <div class="bg-yellow-50 mt-6 text-yellow-600 p-4 text-sm">
      Here is where you would present payment options, for the demo we're just using an Example payment method with makes an offline payment.
      No card details will be asked nor any money taken.
    </div>
    <div class="text-right mt-6">
      <button class="bg-indigo-600 text-white rounded px-6 py-3 hover:bg-indigo-700">
        Complete order
      </button>
    </div>
  </form>
</template>

<script>
import CheckoutAddress from '~/components/checkout/CheckoutAddress.vue'
const first = require('lodash/first')

export default {
  components: {
    CheckoutAddress
  },
  props: {
    value: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      paymentType: null
    }
  },
  async mounted () {
    /**
     * Here you will probably want to put them into an array of options
     * for users to choose from
     */
    const response = await this.$getcandy.on('Payments').getPaymentsTypes()
    this.paymentType = first(response.data)
  },
  methods: {
    save () {
      this.$emit('save', {
        paymentTypeId: this.paymentType.id
      })
    }
  }
}
</script>
