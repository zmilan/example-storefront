<template>
  <div>
    <div class="my-8 text-3xl">
      Checkout
    </div>
    <div v-if="loading">
      <!-- By Sam Herbert (@sherb), for everyone. More @ http://goo.gl/7AJzbL -->
      <svg width="38" height="38" class="mx-auto" viewBox="0 0 38 38" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <linearGradient id="a" x1="8.042%" y1="0%" x2="65.682%" y2="23.865%">
            <stop stop-color="#000" stop-opacity="0" offset="0%" />
            <stop stop-color="#000" stop-opacity=".631" offset="63.146%" />
            <stop stop-color="#000" offset="100%" />
          </linearGradient>
        </defs>
        <g fill="none" fill-rule="evenodd">
          <g transform="translate(1 1)">
            <path id="Oval-2" d="M36 18c0-9.94-8.06-18-18-18" stroke="url(#a)" stroke-width="2">
              <animateTransform
                attributeName="transform"
                type="rotate"
                from="0 18 18"
                to="360 18 18"
                dur="0.9s"
                repeatCount="indefinite"
              />
            </path>
            <circle fill="currentColor" cx="36" cy="18" r="1">
              <animateTransform
                attributeName="transform"
                type="rotate"
                from="0 18 18"
                to="360 18 18"
                dur="0.9s"
                repeatCount="indefinite"
              />
            </circle>
          </g>
        </g>
      </svg>
    </div>
    <div v-if="!loading" class="flex">
      <div class="w-2/3 mr-24">
        <div class="grid grid-cols-3 gap-4 mb-8">
          <button
            :class="{
              'bg-indigo-50 text-indigo-500': step === 1
            }"
            class="px-4 py-2 rounded"
            @click="step = 1"
          >
            Shipping address
          </button>
          <button
            :class="{
              'bg-indigo-50 text-indigo-500': step === 2
            }"
            class="px-4 py-2 rounded"
          >
            Shipping method
          </button>
          <button
            :class="{
              'bg-indigo-50 text-indigo-500': step === 3
            }"
            class="px-4 py-2 rounded"
          >
            Billing &amp; Payment
          </button>
        </div>
        <step-one
          v-show="step === 1"
          v-model="order.shipping_details"
          @save="saveStepOne"
        />
        <step-two
          v-if="step === 2"
          v-model="shippingPriceId"
          :order="order"
          @save="saveStepTwo"
        />
        <step-three
          v-if="step === 3"
          v-model="order.billing_details"
          @save="saveStepThree"
        />
      </div>
      <div class="w-1/3">
        <h3 class="font-bold mb-4">
          Summary
        </h3>
        <div v-for="line in basketLines" :key="line.id" class="flex items-center border-b py-4 border-gray-200">
          <span class="w-12 mr-4">
            {{ line.quantity }} x
          </span>
          <span class="w-full">
            {{ line.description }}
            <span class="text-blue-500 block text-xs">{{ line.sku }}</span>
          </span>
          <span class="text-gray-600">
            {{ format(line.line_total) }}
          </span>
        </div>
        <div v-if="shippingLines.length" class="mt-4">
          <h3 class="font-bold">
            Shipping
          </h3>
          <div v-for="line in shippingLines" :key="line.id" class="flex items-center border-b py-4 border-gray-200">
            <span class="w-full">
              {{ line.description }}
              <span class="text-blue-500 block text-xs">{{ line.sku }}</span>
            </span>
            <span class="text-gray-600">
              {{ format(line.line_total) }}
            </span>
          </div>
        </div>
        <div class="text-right mt-4">
          <p><strong>Sub Total:</strong> {{ subTotal }}</p>
          <p><strong>Tax:</strong> {{ tax }}</p>
          <p><strong>Total:</strong> {{ total }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Cookies from 'js-cookie'
import StepOne from '~/components/checkout/StepOne.vue'
import StepTwo from '~/components/checkout/StepTwo.vue'
import StepThree from '~/components/checkout/StepThree.vue'
const currency = require('currency.js')
const filter = require('lodash/filter')

export default {
  components: {
    StepOne,
    StepTwo,
    StepThree
  },
  data () {
    return {
      loading: true,
      step: 1,
      order: {},
      shippingPriceId: null
    }
  },
  computed: {
    total () {
      return this.format(this.order.order_total)
    },
    basketLines () {
      return filter(this.lines, (line) => {
        return !line.is_manual && !line.is_shipping
      })
    },
    shippingLines () {
      return filter(this.lines, (line) => {
        return line.is_shipping
      })
    },
    subTotal () {
      return this.format(this.order.sub_total)
    },
    tax () {
      return this.format(this.order.tax_total)
    },
    basketId () {
      return this.$store.state.basket.id
    },
    lines () {
      return this.order.lines.data
    }
  },
  mounted () {
    this.$nextTick(async () => {
      if (!this.basketId) {
        this.$router.push('/')
      }
      const order = await this.$getcandy.on('Orders').postOrders({
        createOrderBody: {
          basket_id: this.basketId,
          include: 'lines'
        }
      })
      this.order = order.data
      this.loading = false
    })
  },
  methods: {
    format (val) {
      return currency(val / 100, { symbol: '£', formatWithSymbol: true }).format()
    },
    async saveStepOne () {
      await this.$getcandy.on('Orders').putOrdersIdShippingAddress(this.order.id, {
        address: this.order.shipping_details
      })
      this.step = 2
    },
    async saveStepThree ({ paymentTypeId }) {
      try {
        await this.$getcandy.on('Orders').putOrdersOrderIdBillingAddress(this.order.id, {
          address: this.order.billing_details
        })
        const response = await this.$getcandy.on('Orders').postOrdersProcess({
          inlineObject1: {
            order_id: this.order.id,
            payment_type_id: paymentTypeId
          }
        })
        Cookies.set('gc-order-reference', response.data.reference)
        this.$store.dispatch('basket/clear')

        this.$router.push({
          name: 'checkout-success'
        })
      } catch (error) {
      }
    },
    async saveStepTwo ({ shippingPriceId }) {
      const response = await this.$getcandy.on('Orders').putOrdersIdShippingCost(this.order.id, {
        inlineObject12: {
          price_id: shippingPriceId
        },
        include: 'lines'
      })
      this.order = response.data
      this.step = 3
    }
  }
}
</script>
