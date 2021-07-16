<template>
  <v-dialog v-model="linkDialog" width="500">
    <template v-slot:activator="{ on, attrs }">
      <v-btn outlined block color="primary" v-bind="attrs" v-on="on">
        <v-icon class="mr-3">mdi-open-in-new</v-icon>
        <span class="my-auto">販売サイトへ</span>
      </v-btn>
    </template>
    <v-card class="py-2">
      <v-btn icon absolute right @click="linkDialog = false">
        ✕
      </v-btn>
      <v-card-title class="mt-2 pt-5 justify-center text-subtitle-1">
        下記URLの外部サイトへ移動します
      </v-card-title>
      <v-divider class="mb-5" />
      <v-card-title class="justify-center text-subtitle-1">
        {{ itemLink }}
      </v-card-title>
      <v-card-actions class="justify-center">
        <a
          :href="itemLink"
          target="_blank"
          rel="noopener noreferrer"
          class="text-decoration-none"
        >
          <v-btn
            outlined
            block
            color="primary"
            v-bind="attrs"
            v-on="on"
            @click="linkDialog = false"
          >
            <v-icon class="mr-3">mdi-open-in-new</v-icon>
            <span class="my-auto">移動する</span>
          </v-btn>
        </a>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    itemLink: {
      type: undefined,
      required: true
    }
  },
  data() {
    return {
      linkDialog: false
    }
  }
}
</script>
