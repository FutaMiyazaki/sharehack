<template>
  <v-row>
    <v-col cols="12" class="pb-0">
      <v-subheader class="black--text">
        プロフィール画像
      </v-subheader>
      <v-divider />
    </v-col>
    <v-col cols="12" class="pt-0">
      <v-card flat>
        <v-card-text class="pt-8">
          <p class="mb-3 text-caption red--text">
            ※新たに画像をアップロードしない場合は変更されません
          </p>
          <validation-observer v-slot="{ invalid }">
            <v-form ref="form" lazy-validation>
              <validation-provider
                v-slot="{ errors, validate }"
                rules="required|size:5000"
              >
                <v-file-input
                  v-model="previewImage"
                  counter
                  outlined
                  rows="1"
                  background-color="secondary"
                  :value="image"
                  accept="image/*"
                  truncate-length="25"
                  label="画像をアップロードする"
                  :error-messages="errors"
                  show-size
                  @input="validate($event)"
                  @change="setImage"
                />
              </validation-provider>
              <v-img
                v-if="previewImageUrl"
                aspect-ratio="1"
                alt="プロフィール画像のプレビュー表示"
                :src="previewImageUrl"
                class="mb-5"
              />
              <v-card-actions class="justify-center">
                <v-row v-if="currentUser.email != guest" justify="center">
                  <v-col cols="12" sm="4">
                    <v-btn
                      block
                      rounded
                      color="primary"
                      class="white--text font-weight-bold d-block mx-auto"
                      :disabled="invalid"
                      @click="updateAvatar"
                    >
                      プロフィール画像を変更
                    </v-btn>
                  </v-col>
                </v-row>
                <p v-if="currentUser.email == guest" class="font-weight-bold">
                  ゲストユーザーのため変更できません
                </p>
              </v-card-actions>
            </v-form>
          </validation-observer>
        </v-card-text>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data() {
    return {
      image: null,
      previewImage: null,
      guest: 'guest@sharehack.com'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    }),
    previewImageUrl() {
      if (this.previewImage === null) {
        return false
      } else {
        return URL.createObjectURL(this.previewImage)
      }
    }
  },
  methods: {
    ...mapActions({
      showMessage: 'flashMessage/showMessage',
      getAvatar: 'authentication/getAvatar'
    }),
    setImage(e) {
      this.image = e
    },
    async updateAvatar() {
      const data = new FormData()
      const config = {
        headers: {
          'content-type': 'multipart/form-data'
        }
      }
      data.append('user[avatar]', this.image)
      data.append('user[uid]', localStorage.getItem('uid'))
      await this.$axios
        .patch(
          `api/v1/users/${this.currentUser.id}/update_avatar`,
          data,
          config
        )
        .then((response) => {
          this.getAvatar(this.currentUser.id)
          this.$router.push(`/users/${response.data.id}`)
          this.showMessage({
            text: 'プロフィール画像を変更しました。',
            type: 'success',
            status: true
          })
        })
        .catch((error) => {
          this.showMessage({
            text: 'プロフィール画像の変更に失敗しました。',
            type: 'error',
            status: true
          })
          return error
        })
    }
  }
}
</script>
