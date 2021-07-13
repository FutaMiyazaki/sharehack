<template>
  <v-row justify="center">
    <v-col cols="12" lg="6" md="5">
      <v-row justify="center">
        <v-col v-if="icon" cols="12" class="py-0 text-center">
          <v-icon large class="d-block mb-3">{{ icon }}</v-icon>
        </v-col>
        <v-col cols="12" class="py-0">
          <p class="text-center subtitle-2 pb-2">
            {{ text }}
          </p>
        </v-col>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    icon: {
      type: String,
      required: false,
      default: ''
    },
    text: {
      type: String,
      required: true
    }
  }
}
</script>
