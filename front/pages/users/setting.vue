<template>
  <v-app>
    <v-container class="pt-0">
      <PageHeader text="アカウント設定" />
      <v-card flat class="mx-auto">
        <v-tabs v-model="tab" show-arrows left>
          <v-tab>ユーザー名 </v-tab>
          <v-tab>プロフィール画像 </v-tab>
          <v-tab>メールアドレス </v-tab>
          <v-tab>パスワード </v-tab>
          <v-tab>その他の設定 </v-tab>
        </v-tabs>
        <v-tabs-items v-model="tab">
          <v-tab-item>
            <EditProfile />
          </v-tab-item>
          <v-tab-item>
            <EditAvatar />
          </v-tab-item>
          <v-tab-item>
            <EditEmail />
          </v-tab-item>
          <v-tab-item>
            <EditPassword />
          </v-tab-item>
          <v-tab-item>
            <EditOther />
          </v-tab-item>
        </v-tabs-items>
      </v-card>
    </v-container>
  </v-app>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'
import EditProfile from '~/components/setting/EditProfile.vue'
import EditAvatar from '~/components/setting/EditAvatar.vue'
import EditEmail from '~/components/setting/EditEmail.vue'
import EditPassword from '~/components/setting/EditPassword.vue'
import EditOther from '~/components/setting/EditOther.vue'

export default {
  components: {
    PageHeader,
    EditProfile,
    EditAvatar,
    EditEmail,
    EditPassword,
    EditOther
  },
  data() {
    return {
      tab: null
    }
  },
  head() {
    return {
      title: '設定'
    }
  }
}
</script>
