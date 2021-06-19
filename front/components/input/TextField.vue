<template>
  <validation-provider v-slot="{ errors }" :rules="rules" mode="lazy">
    <v-text-field
      v-model="inputValue"
      :type="type"
      outlined
      rows="1"
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
    type: {
      type: String,
      required: false,
      default: ''
    },
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
