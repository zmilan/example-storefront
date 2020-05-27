import Cookies from 'js-cookie'
const GetCandy = require('@getcandy/js-client')
const map = require('lodash/map')
const find = require('lodash/find')
const findIndex = require('lodash/findIndex')

export const state = () => ({
  id: null,
  total: 0,
  subTotal: 0,
  taxTotal: 0,
  lines: []
})

export const mutations = {
  setId (state, id) {
    state.id = id
  },
  setLines (state, lines) {
    state.lines = lines
  },
  removeLine (state, lineId) {
    const lines = state.lines
    const line = find(lines, line => line.id === lineId)
    const index = findIndex(lines, line)
    lines.splice(index, 1)
    state.lines = lines
  },
  setTotal (state, total) {
    state.total = total
  },
  setTaxTotal (state, total) {
    state.taxTotal = total
  },
  setSubTotal (state, total) {
    state.subTotal = total
  }
}

export const actions = {
  removeLine ({ state, commit, dispatch }, lineId) {
    commit('removeLine', lineId)
    dispatch('updateLines', map(state.lines, (line) => {
      return {
        quantity: parseInt(line.quantity),
        id: line.variant.data.id
      }
    }))
  },
  async updateLines ({ commit }, lines) {
    const client = new GetCandy.BasketsApi()

    const response = await client.postBasketLines({
      createBasketLinesBody: {
        basketId: Cookies.get('gc-basket-id'),
        variants: lines
      }
    })

    commit('setLines', response.data.lines.data)
    commit('setLines', response.data.lines.data)
    commit('setSubTotal', response.data.sub_total)
    commit('setTotal', response.data.total)
    commit('setTaxTotal', response.data.tax_total)
    commit('setId', response.data.id)
    Cookies.set('gc-basket-id', response.data.id)
  },
  async resurrect ({ state, commit }) {
    const basketId = Cookies.get('gc-basket-id')
    commit('setId', basketId)
    if (basketId) {
      const client = new GetCandy.BasketsApi()
      const response = await client.getBasketsBasketId(basketId)
      commit('setLines', response.data.lines.data)
      commit('setSubTotal', response.data.sub_total)
      commit('setTotal', response.data.total)
      commit('setTaxTotal', response.data.tax_total)
    }
  },
  clear ({ commit }) {
    commit('setId', null)
    commit('setLines', [])
    commit('setSubTotal', 0)
    commit('setTotal', 0)
    commit('setTaxTotal', 0)
    Cookies.remove('gc-basket-id')
  },
  add ({ commit, state, dispatch }, variant) {
    const lines = map(state.lines, (line) => {
      return {
        quantity: parseInt(line.quantity),
        id: line.variant.data.id
      }
    })

    // Determine whether the product already exists and if so, just update the quantity
    const existing = find(lines, (line) => {
      return line.id === variant.id
    })

    if (existing) {
      const index = findIndex(lines, existing)
      lines[index].quantity += parseInt(variant.quantity)
    } else {
      lines.push(variant)
    }

    dispatch('updateLines', lines)
  }
}
