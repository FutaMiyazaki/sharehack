<template>
  <v-dialog v-model="dialog" width="500">
    <template v-slot:activator="{ on, attrs }">
      <v-btn block rounded outlined color="primary" v-bind="attrs" v-on="on">
        <v-icon class="mr-3">mdi-open-in-new</v-icon>
        <span class="my-auto">販売サイトへ</span>
      </v-btn>
    </template>
    <v-card class="py-2">
      <v-card-actions class="px-2 py-0">
        <v-icon class="ml-auto" @click="dialog = false">mdi-close</v-icon>
      </v-card-actions>
      <v-card-title class="pt-1 justify-center text-subtitle-1">
        下記URLの外部サイトへ移動します。当サイトが運営するページではありませんのでご注意ください。
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
          <v-btn block rounded outlined color="primary" @click="dialog = false">
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
      dialog: false
    }
  }
}
</script>
