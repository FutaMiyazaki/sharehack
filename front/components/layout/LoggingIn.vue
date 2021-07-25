<template>
  <v-row justify="center" class="mt-7">
    <v-col cols="12" md="6" class="py-0 text-center">
      <v-alert outlined color="primary" class="pa-3">
        <div>
          <v-icon left color="primary" class="mb-1"
            >mdi-alert-circle-outline</v-icon
          >ログイン中です
        </div>
        <v-btn
          nuxt
          block
          rounded
          color="primary"
          to="/"
          class="mt-5 font-weight-bold"
        >
          トップページへ戻る
        </v-btn>
      </v-alert>
    </v-col>
  </v-row>
</template>
