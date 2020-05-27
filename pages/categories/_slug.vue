<template>
  <div>
    <div class="my-8 text-3xl">
      {{ category.name }}
    </div>
    <div class="w-full">
      <div class="grid grid-cols-4 gap-4 py-8">
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
</template>

<script>
import ProductCard from '~/components/ProductCard.vue'

export default {
  components: {
    ProductCard
  },
  async asyncData ({ app, params, error }) {
    try {
      const route = await app.$getcandy.on('Routes').getRoutesSlug(params.slug, {
        include: 'element'
      })
      if (route.data.type !== 'category') {
        error({
          statusCode: 404
        })
      }
      const category = await app.$getcandy.on('Categories').getCategoriesCategoryId(route.data.element.data.id, {
        includes: 'assets.transforms'
      })

      const products = await app.$getcandy.on('Search').getSearch({
        per_page: 3,
        category: category.data.id,
        include: 'first_variant,thumbnail,routes'
      })

      return {
        products,
        category: category.data
      }
    } catch (error) {
      error({
        statusCode: 404
      })
    }
  },
  computed: {
    pagination () {
      return this.products.meta.pagination.data
    }
  }
}
</script>
