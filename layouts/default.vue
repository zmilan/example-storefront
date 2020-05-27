<template>
  <div>
    <div>
      <nav-bar />
    </div>
    <div class="max-w-7xl mx-auto px-4 sm:px-6">
      <nuxt />
    </div>
  </div>
</template>

<script>
import NavBar from '~/components/NavBar.vue'

export default {
  components: {
    NavBar
  },
  mounted () {
    this.$store.dispatch('basket/resurrect')
  }
}
</script>
