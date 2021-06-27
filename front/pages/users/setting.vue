<template>
  <v-app>
    <v-container class="pt-0">
      <PageHeader text="アカウント設定" />
      <v-card flat class="mx-auto">
        <v-tabs v-model="tab" show-arrows left>
          <v-tab> <v-icon>mdi-account-edit</v-icon>ユーザー名 </v-tab>
          <v-tab> <v-icon>mdi-image-edit</v-icon>プロフィール画像 </v-tab>
          <v-tab> <v-icon>mdi-email-edit</v-icon>メールアドレス </v-tab>
          <v-tab> <v-icon>mdi-lock</v-icon>パスワード </v-tab>
          <v-tab> <v-icon>mdi-alert</v-icon>その他の設定 </v-tab>
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
import EditProfile from '~/components/editUser/EditProfile.vue'
import EditAvatar from '~/components/editUser/EditAvatar.vue'
import EditEmail from '~/components/editUser/EditEmail.vue'
import EditPassword from '~/components/editUser/EditPassword.vue'
import EditOther from '~/components/editUser/EditOther.vue'

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
  }
}
</script>
