<template>
  <validation-provider v-slot="{ errors }" :rules="rules" mode="lazy">
    <v-textarea
      v-model="inputValue"
      counter
      auto-grow
      outlined
      rows="3"
      background-color="secondary"
      :prepend-icon="icon"
      :label="label"
      :error-messages="errors"
    />
  </validation-provider>
</template>

<script>
export default {
  props: {
    rules: {
      type: String,
      required: false,
      default: ''
    },
    icon: {
      type: String,
      required: false,
      default: ''
    },
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
