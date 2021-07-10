<template>
  <validation-provider v-slot="{ errors }" rules="required|max:50" mode="lazy">
    <v-text-field
      v-model="inputValue"
      outlined
      rows="1"
      background-color="secondary"
      :type="showPassword ? 'text' : 'password'"
      prepend-icon=""
      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
      :label="label"
      :error-messages="errors"
      @click:append="showPassword = !showPassword"
    />
  </validation-provider>
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      required: true,
      default: ''
    },
    value: {
      type: null,
      required: false,
      default: ''
    }
  },
  data() {
    return {
      showPassword: false
    }
  },
  computed: {
    inputValue: {
      get() {
        return this.value
      },
      set(value) {
        this.$emit('input', value)
      }
    }
  }
}
</script>
