<template>
  <v-app>
    <v-container class="pt-0">
      <PageHeader text="アカウント設定" />
      <v-row class="mt-5">
        <v-col cols="12" md="4">
          <v-card flat class="mx-auto">
            <v-list nav dense rounded>
              <v-list-item-group v-model="selectedItem" color="primary">
                <v-list-item @click="currentComponent = 'EditProfile'">
                  <v-list-item-icon>
                    <v-icon>mdi-account-edit</v-icon>
                  </v-list-item-icon>
                  <v-list-item-content>
                    <v-list-item-title>プロフィール名</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
                <v-list-item @click="currentComponent = 'EditAvatar'">
                  <v-list-item-icon>
                    <v-icon>mdi-image-edit</v-icon>
                  </v-list-item-icon>
                  <v-list-item-content>
                    <v-list-item-title>プロフィール画像</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
                <v-list-item @click="currentComponent = 'EditEmail'">
                  <v-list-item-icon>
                    <v-icon>mdi-email-edit</v-icon>
                  </v-list-item-icon>
                  <v-list-item-content>
                    <v-list-item-title>メールアドレス</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
                <v-list-item @click="currentComponent = 'EditPassword'">
                  <v-list-item-icon>
                    <v-icon>mdi-lock</v-icon>
                  </v-list-item-icon>
                  <v-list-item-content>
                    <v-list-item-title>パスワード</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
                <v-list-item @click="currentComponent = 'EditOther'">
                  <v-list-item-icon>
                    <v-icon>mdi-alert-circle</v-icon>
                  </v-list-item-icon>
                  <v-list-item-content>
                    <v-list-item-title>その他の設定</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </v-card>
        </v-col>
        <v-col cols="12" lg="8" md="8">
          <component :is="currentComponent" />
        </v-col>
      </v-row>
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
      currentComponent: 'EditProfile'
    }
  },
  head() {
    return {
      title: '設定'
    }
  }
}
</script>
