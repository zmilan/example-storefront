<template>
  <button class="bg-indigo-600 text-white px-4 py-2 rounded" @click="add">
    Add to basket
  </button>
</template>

<script>
export default {
  props: {
    variantId: {
      type: String,
      required: true
    },
    quantity: {
      type: Number,
      default: 1
    }
  },
  methods: {
    add () {
      this.$store.dispatch('basket/add', {
        id: this.variantId,
        quantity: this.quantity
      })
    }
  }
}
</script>
