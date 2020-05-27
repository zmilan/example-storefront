export const state = () => ({
  keywords: null,
  page: 1
})

export const mutations = {
  setKeywords (state, keywords) {
    state.keywords = keywords
  },
  setPage (state, page) {
    state.page = page
  }
}
