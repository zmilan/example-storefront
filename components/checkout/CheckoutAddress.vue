<template>
  <div>
    <div class="grid grid-cols-2 gap-4">
      <div>
        <label for="firstName" class="block text-sm font-medium leading-5 text-gray-700">First name</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <input id="firstName" v-model="address.firstname" class="form-input block w-full sm:text-sm sm:leading-5" required>
        </div>
      </div>
      <div>
        <label for="lastName" class="block text-sm font-medium leading-5 text-gray-700">Last name</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <input id="lastName" v-model="address.lastname" class="form-input block w-full sm:text-sm sm:leading-5" required>
        </div>
      </div>
    </div>
    <div class="grid grid-cols-2 gap-4 mt-4">
      <div>
        <label for="phone" class="block text-sm font-medium leading-5 text-gray-700">Phone</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <input id="phone" v-model="address.phone" type="tel" class="form-input block w-full sm:text-sm sm:leading-5" required>
        </div>
      </div>
      <div>
        <label for="email" class="block text-sm font-medium leading-5 text-gray-700">Email</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <input id="email" v-model="address.email" type="email" class="form-input block w-full sm:text-sm sm:leading-5" required>
        </div>
      </div>
    </div>
    <div class="mt-4">
      <div>
        <label for="lineOne" class="block text-sm font-medium leading-5 text-gray-700">Address Line 1</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <input id="lineOne" v-model="address.address" class="form-input block w-full sm:text-sm sm:leading-5" required>
        </div>
      </div>
    </div>
    <div class="grid grid-cols-3 gap-4 mt-4">
      <div>
        <label for="lineTwo" class="block text-sm font-medium leading-5 text-gray-700">Address line 2</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <input id="lineTwo" v-model="address.address_two" class="form-input block w-full sm:text-sm sm:leading-5">
        </div>
      </div>
      <div>
        <label for="city" class="block text-sm font-medium leading-5 text-gray-700">City</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <input id="city" v-model="address.city" class="form-input block w-full sm:text-sm sm:leading-5" required>
        </div>
      </div>
      <div>
        <label for="county" class="block text-sm font-medium leading-5 text-gray-700">County</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <input id="county" v-model="address.county" class="form-input block w-full sm:text-sm sm:leading-5" required>
        </div>
      </div>
    </div>
    <div class="grid grid-cols-2 gap-4 mt-4">
      <div>
        <label for="zip" class="block text-sm font-medium leading-5 text-gray-700">Postal Code</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <input id="zip" v-model="address.zip" class="form-input block w-full sm:text-sm sm:leading-5">
        </div>
      </div>
      <div>
        <label for="city" class="block text-sm font-medium leading-5 text-gray-700">Country</label>
        <div class="mt-1 relative rounded-md shadow-sm">
          <div class="relative">
            <select v-model="address.country" class="disabled:opacity-75 disabled:cursor-not-allowed appearance-none w-full form-input pr-8 rounded leading-tight">
              <option :value="null" disabled>
                Please select
              </option>
              <option value="United Kingdom">
                United Kingdom
              </option>
              <option value="France">
                France
              </option>
              <option value="United States">
                United States
              </option>
            </select>
            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
              <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    value: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      address: {}
    }
  },
  mounted () {
    this.address = this.value
  }
}
</script>
