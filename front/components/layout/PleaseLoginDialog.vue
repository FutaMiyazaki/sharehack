<template>
  <v-dialog v-model="dialog" width="500">
    <template v-slot:activator="{ on, attrs }">
      <v-btn block rounded depressed :color="btnColor" v-bind="attrs" v-on="on">
        <v-icon :color="btnIconColor">{{ btnIcon }}</v-icon>
        <p class="my-auto mx-2">{{ btnText }}</p>
        <template v-if="btnText == 'いいね!'">
          <span class="font-weight-bold">{{ likeCount }}</span>
        </template>
      </v-btn>
    </template>
    <v-card class="py-2">
      <v-card-actions class="px-2 py-0">
        <v-icon class="ml-auto" @click="dialog = false">
          mdi-close
        </v-icon>
      </v-card-actions>
      <v-card-title class="pt-1 justify-center text-subtitle-1">
        ユーザー登録して、もっと便利に使ってみませんか。
      </v-card-title>
      <v-divider class="mb-5" />
      <v-card-text class="justify-center text-subtitle-2">
        この機能を利用するにはログインまたはアカウント作成が必要です。
      </v-card-text>
      <v-card-actions class="justify-center">
        <v-btn
          block
          rounded
          outlined
          color="primary"
          class="white--text font-weight-bold"
          to="/users/signup"
        >
          アカウント作成
        </v-btn>
      </v-card-actions>
      <v-card-actions class="justify-center">
        <v-btn
          block
          rounded
          color="primary"
          class="white--text font-weight-bold"
          to="/users/login"
        >
          ログイン
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    btnColor: {
      type: String,
      required: false,
      default: ''
    },
    btnIcon: {
      type: String,
      required: false,
      default: ''
    },
    btnIconColor: {
      type: String,
      required: false,
      default: ''
    },
    btnText: {
      type: String,
      required: true
    },
    likeCount: {
      type: Number,
      required: false,
      default: 0
    }
  },
  data() {
    return {
      dialog: false
    }
  }
}
</script>
