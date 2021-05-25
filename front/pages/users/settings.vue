<template>
  <v-app>
    <v-container class="pt-0">
      <PageHeader :text="text" />
      <v-card class="mx-auto">
        <v-tabs v-model="tab" show-arrows grow>
          <v-tab>
            <v-icon>mdi-account-edit</v-icon>
          </v-tab>
          <v-tab>
            <v-icon>mdi-email-edit</v-icon>
          </v-tab>
          <v-tab>
            <v-icon>mdi-lock</v-icon>
          </v-tab>
          <v-tab>
            <v-icon>mdi-alert</v-icon>
          </v-tab>
        </v-tabs>

        <v-tabs-items v-model="tab">
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
        </v-tabs-items>
      </v-card>
    </v-container>
  </v-app>
</template>

<script>
import PageHeader from '~/components/layout/PageHeader.vue'
import EditProfile from '~/components/EditUser/EditProfile.vue'
import EditEmail from '~/components/EditUser/EditEmail.vue'
import EditPassword from '~/components/EditUser/EditPassword.vue'
import EditOther from '~/components/EditUser/EditOther.vue'

export default {
  components: {
    PageHeader,
    EditProfile,
    EditEmail,
    EditPassword,
    EditOther
  },
  data() {
    return {
      text: 'アカウント設定',
      tab: null,
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
