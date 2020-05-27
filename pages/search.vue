<template>
  <div>
    <div class="flex mt-12">
      <div class="w-1/3 mr-12">
        <h2 class="font-bold border-b pb-2 mb-4">
          Categories
        </h2>
        <div v-for="category in aggregates.categories.data" :key="category.id" class="flex justify-between mb-2">
          <span>{{ category.attribute_data.name.webstore.en }}</span>
          <span>({{ category.doc_count }})</span>
        </div>
      </div>
      <div class="w-full">
        <div class="grid grid-cols-3 gap-4 py-8">
          <product-card v-for="product in products.data" :key="product.id" :product="product" />
        </div>
        <pagination
          :total-records="pagination.total"
          :showing="pagination.count"
          :current-page="pagination.current_page"
          :total-pages="pagination.total_pages"
          @changePage="changePage"
        />
      </div>
    </div>
  </div>
</template>

<script>
import Pagination from '~/components/Pagination.vue'
import ProductCard from '~/components/ProductCard.vue'

export default {
  components: {
    Pagination,
    ProductCard
  },
  beforeRouteLeave (to, from, next) {
    this.$store.commit('search/setKeywords', null)
    next()
  },
  async asyncData ({ app, query }) {
    const products = await app.$getcandy.on('Search').getSearch({
      per_page: 3,
      keywords: query.keywords,
      include: 'first_variant,thumbnail,routes'
    })
    return {
      products
    }
  },
  data () {
    return {
      searching: true,
      page: 1
    }
  },
  computed: {
    pagination () {
      return this.products.meta.pagination.data
    },
    keywords () {
      return this.$store.state.search.keywords
    },
    aggregates () {
      return this.products.meta.aggregation.data
    }
  },
  watch: {
    keywords () {
      this.search()
    }
  },
  methods: {
    changePage (page) {
      this.page = page
      this.search()
    },
    async search () {
      this.products = await this.$getcandy.on('Search').getSearch({
        include: 'first_variant,thumbnail,routes',
        page: this.page,
        per_page: 3,
        keywords: this.keywords
      })
    }
  }
}
</script>
