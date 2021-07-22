<template>
  <v-card
    flat
    nuxt
    :to="'/topic/' + topic.id"
    class="mb-5 rounded-lg"
    color="secondary"
  >
    <v-card-subtitle class="text-subtitle-2 pb-2"
      >所属トピック：</v-card-subtitle
    >
    <v-card-title
      class="text-subtitle-1 text-decoration-underline blue--text text--lighten-2 pt-0 pb-2"
    >
      {{ topic.title }}
    </v-card-title>
    <v-card-text class="text-caption">
      <p
        style="white-space:pre-wrap;"
        class="mb-0"
        v-text="topic.description"
      ></p>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    topic: {
      type: Object,
      require: true,
      default: () => ({
        id: '',
        title: '',
        description: ''
      })
    }
  }
}
</script>
