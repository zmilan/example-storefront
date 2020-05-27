<template>
  <form @submit.prevent="save">
    <checkout-address v-model="value" />
    <div class="text-right mt-6">
      <button class="bg-indigo-600 text-white rounded px-6 py-3 hover:bg-indigo-700">
        Continue to shipping method
      </button>
    </div>
  </form>
</template>

<script>
import CheckoutAddress from '~/components/checkout/CheckoutAddress.vue'

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
      address: {}
    }
  },
  methods: {
    save () {
      this.$emit('save')
    }
  }
}
</script>
