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
            <edit-profile />
          </v-tab-item>
          <v-tab-item>
            <edit-email />
          </v-tab-item>
          <v-tab-item>
            <edit-password />
          </v-tab-item>
          <v-tab-item>
            <edit-other />
          </v-tab-item>
        </v-tabs>
      </v-card>
    </v-container>
  </v-app>
</template>

<script>
import editProfile from '~/components/editUser/editProfile.vue'
import editEmail from '~/components/editUser/editEmail.vue'
import editPassword from '~/components/editUser/editPassword.vue'
import editOther from '~/components/editUser/editOther.vue'

export default {
  components: {
    editProfile,
    editEmail,
    editPassword,
    editOther
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
