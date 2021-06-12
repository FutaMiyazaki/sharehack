<template>
  <v-card class="mx-auto" tile>
    <v-list>
      <v-list-item>
        <v-list-item-avatar> </v-list-item-avatar>
      </v-list-item>
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title class="text-center">
            {{ userName }}
          </v-list-item-title>
          <v-list-item-subtitle class="text-center">
            {{ itemsCount }}件の投稿
          </v-list-item-subtitle>
          <v-divider class="my-5" />
          <div>
            <v-btn v-show="currentUserId !== userId" block>
              <v-icon class="mr-3" color="primary">mdi-account-plus</v-icon>
              <p class="my-auto">フォローする</p>
            </v-btn>
            <v-btn
              v-show="currentUserId === userId"
              outlined
              block
              color="primary"
              @click="toSetting"
            >
              <v-icon class="mr-3">mdi-cog</v-icon>
              <p class="my-auto">アカウントを編集する</p>
            </v-btn>
          </div>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <v-divider></v-divider>
    <v-list nav dense>
      <v-list-item-group v-model="selectedItem" color="primary">
        <v-list-item :to="`/users/${userId}`">
          <v-list-item-icon>
            <v-icon>mdi-folder</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>すべての投稿</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item :to="`/mylike/${userId}`">
          <v-list-item-icon>
            <v-icon>mdi-heart</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>いいねした投稿</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </v-card>
</template>

<script>
export default {
  props: {
    userName: {
      type: String,
      required: true,
      default: ''
    },
    itemsCount: {
      type: Number,
      required: false,
      default: 0
    },
    userId: {
      type: Number,
      required: true,
      default: 0
    },
    currentUserId: {
      type: Number,
      required: false,
      default: 0
    },
    selectedItem: {
      type: String,
      required: true,
      default: ''
    }
  },
  methods: {
    toSetting() {
      this.$router.push('/users/setting')
    }
  }
}
</script>
