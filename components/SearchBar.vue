<template>
  <form @submit.prevent="sendSearch">
    <input
      class="border rounded w-full px-4 py-2 shadow"
      :value="keywords"
      placeholder="Search for products"
      @input="updateSearchKeywords($event.target.value)"
    >
  </form>
</template>

<script>
export default {
  data () {
    return {
    }
  },
  computed: {
    keywords () {
      return this.$store.state.search.keywords
    }
  },
  mounted () {
    this.updateSearchKeywords(
      this.$route.query.keywords
    )
  },
  methods: {
    sendSearch () {
      this.$router.push({
        name: 'search',
        query: {
          keywords: this.keywords
        }
      })
    },
    updateSearchKeywords (value) {
      this.$store.commit('search/setKeywords', value)
    }
  }
}
</script>
