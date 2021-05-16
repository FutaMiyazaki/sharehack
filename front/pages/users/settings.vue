<template>
  <v-app>
    <v-container>
      <v-card width="800px" class="mx-auto">
        <v-tabs vertical>
          <v-tab>
            <v-icon left>mdi-account-edit</v-icon>
            プロフィール
          </v-tab>
          <v-tab>
            <v-icon left>mdi-email-edit</v-icon>
            メールアドレス
          </v-tab>
          <v-tab>
            <v-icon left>mdi-lock</v-icon>
            パスワード
          </v-tab>
          <v-tab class="justify-left">
            <v-icon left>mdi-alert</v-icon>
            その他
          </v-tab>
          <v-tab-item>
            <EditProfile />
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
        </v-tabs>
      </v-card>
    </v-container>
  </v-app>
</template>

<script>
import EditProfile from '~/components/editUser/EditProfile.vue'
import EditEmail from '~/components/editUser/EditEmail.vue'
import EditPassword from '~/components/editUser/EditPassword.vue'
import EditOther from '~/components/editUser/EditOther.vue'

export default {
  components: {
    EditProfile,
    EditEmail,
    EditPassword,
    EditOther
  },
  data() {
    return {
      user: {
        email: '',
        password: '',
        password_confirmation: ''
      },
      showPassword: false,
      showConfirmPassword: false
    }
  },
  methods: {}
}
</script>
