const currency = require('currency.js')

export default ({ app }, inject) => {
  // Set the function directly on the context.app object
  inject('currency', (val, cents = true) => {
    return currency(cents ? val / 100 : val, { symbol: '£', formatWithSymbol: true }).format()
  })
}
