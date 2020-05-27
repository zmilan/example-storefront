<template>
  <div>
    <div class="my-8 text-3xl">
      Checkout Confirmation
    </div>
    <p>
      This is the checkout success page, your order has completed!
    </p>
  </div>
</template>

<script>
import Cookies from 'js-cookie'

export default {
  computed: {
    orderReference () {
      return Cookies.get('gc-order-reference')
    }
  },
  mounted () {
    this.$nextTick(() => {
      if (!this.orderReference) {
        this.$router.push({
          name: 'checkout'
        })
      }
    })
  }
}
</script>
