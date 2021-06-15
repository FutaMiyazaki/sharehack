<template>
  <div>
    <h4 class="mb-2">{{ labelTitle }}</h4>
    <p v-if="display" class="mb-2 red--text text-caption">※必須</p>
    <p class="mb-0 text--secondary text-caption">{{ labelText }}</p>
    <p class="text--secondary text-caption">{{ labelSubText }}</p>
  </div>
</template>

<script>
export default {
  props: {
    labelTitle: {
      type: String,
      required: true
    },
    display: {
      type: Boolean,
      default: true
    },
    labelText: {
      type: String,
      default: ''
    },
    labelSubText: {
      type: String,
      default: ''
    }
  }
}
</script>
