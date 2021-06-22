<template>
  <v-list-item class="ma-auto" :to="link">
    <v-list-item-icon>
      <v-icon :color="iconColor">{{ icon }}</v-icon>
    </v-list-item-icon>
    <v-list-item-content>
      <v-list-item-title :class="listItemTitleClass">{{
        text
      }}</v-list-item-title>
    </v-list-item-content>
  </v-list-item>
</template>

<script>
export default {
  props: {
    link: {
      type: String,
      required: true
    },
    iconColor: {
      type: String,
      default: ''
    },
    icon: {
      type: String,
      required: true
    },
    listItemTitleClass: {
      type: String,
      default: ''
    },
    text: {
      type: String,
      required: true
    }
  }
}
</script>
