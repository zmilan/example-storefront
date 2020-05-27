export const state = () => ({
  showTax: true
})

export const mutations = {
  setShowTax (state, showTax) {
    state.showTax = showTax
  }
}

export const actions = {
  toggleTax ({ commit }, showTax) {
    commit('setShowTax', showTax)
  }
}
