<template>
  <div>
    <h1 class="my-8 text-3xl">
      All products
    </h1>

    <div class="grid grid-cols-4 gap-4 py-8">
      <product-card
        v-for="product in products.data"
        :key="product.id"
        :product="product"
      />
    </div>
    <!-- <div class="grid grid-cols-3 gap-4 py-8">
      <div v-for="product in products.data" :key="product.id" class="border overflow-hidden rounded shadow">
        <img :src="product.thumbnail.data.thumbnail">
        <strong class="block">{{ product.attribute_data.name.webstore.en }}</strong>
        {{ product.thumbnail }}
      </div>
    </div>
    <pagination
      :total-records="pagination.total"
      :showing="pagination.count"
      :current-page="pagination.current_page"
      :total-pages="pagination.total_pages"
      @changePage="changePage"
    /> -->
  </div>
</template>

<script>
import ProductCard from '~/components/ProductCard.vue'

export default {
  components: {
    ProductCard
  },
  async asyncData ({ app }) {
    try {
      const products = await app.$getcandy.on('Products').getProducts({
        include: 'firstVariant,primaryAsset.transforms,routes'
      })
      return {
        products
      }
    } catch (error) {
      console.log(error)
    }
  },
  data () {
    return {
      searching: false,
      keywords: null,
      page: 1
    }
  },
  computed: {
    pagination () {
      return this.products.meta.pagination.data
    }
  },
  mounted () {
    // this.$axios.get('api/auth').then((res) => {
    //   // console.log(res)
    // })
  },
  methods: {
    changePage (page) {
      this.page = page
      this.search()
    },
    async search () {
      this.products = await this.$getcandy.on('Search').getSearch({
        include: 'first_variant,thumbnail',
        page: this.page,
        per_page: 3,
        keywords: this.keywords
      })
    }
  }
}
</script>
