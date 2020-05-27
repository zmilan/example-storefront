<template>
  <div class="border-b border-gray-200">
    <div class="my-6 md:my-8 flex justify-between items-center max-w-7xl mx-auto px-4 sm:px-6">
      <div class="flex items-center w-full mr-12">
        <nuxt-link to="/" class="inline-flex mr-12 text-sm font-bold text-gray-600">
          <img src="/logo.png" alt="GetCandy Stamp" class="w-8">
        </nuxt-link>
        <div class="w-2/3">
          <SearchBar />
          <!-- {{ basket }} -->
        </div>
      </div>
      <div>
        <basket-widget />
      </div>
      <div class="pl-8">
        <div class="flex items-center">
          <div>
            <span
              role="checkbox"
              tabindex="0"
              aria-checked="false"
              :class="{
                'bg-gray-200': !showTax,
                'bg-indigo-600': showTax
              }"
              class="relative inline-block flex-shrink-0 h-6 w-11 border-2 border-transparent rounded-full cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus:shadow-outline"
              @click="toggleTax"
            >
              <span
                aria-hidden="true"
                :class="{
                  'translate-x-5': showTax,
                  'translate-x-0': !showTax
                }"
                class="inline-block h-5 w-5 rounded-full bg-white shadow transform transition ease-in-out duration-200"
              />
            </span>
          </div>
          <span class="block ml-2 text-gray-500 text-xs">
            Tax
          </span>
        </div>
      </div>
    </div>
    <!-- Category listing -->
    <div class="border-t border-gray-200 py-4">
      <nav class="max-w-7xl mx-auto px-4 sm:px-6">
        <nuxt-link
          v-for="(category) in categories"
          :key="category.id"
          :to="{
            name: 'categories-slug',
            params: {
              slug: category.routes.data[0].slug
            }
          }"
          class="mr-6 text-gray-500 hover:text-gray-800"
        >
          {{ category.name }}
        </nuxt-link>
      </nav>
    </div>
  </div>
</template>

<script>
import SearchBar from '~/components/SearchBar.vue'
import BasketWidget from '~/components/BasketWidget.vue'

export default {
  components: {
    SearchBar,
    BasketWidget
  },
  data () {
    return {
      showCategories: false,
      categories: []
    }
  },
  computed: {
    showTax () {
      return this.$store.state.showTax
    }
  },
  async mounted () {
    const categories = await this.$getcandy.on('Categories').getCategories({
      tree: true,
      include: 'routes'
    })
    this.categories = categories.data
  },
  methods: {
    toggleTax () {
      this.$store.dispatch('toggleTax', !this.showTax)
    }
  }
}
</script>
