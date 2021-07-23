<template>
  <v-container class="pt-0">
    <PageHeader text="トピックを投稿する" />
    <validation-observer v-slot="{ invalid }">
      <v-form ref="form" lazy-validation class="mt-5">
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel label-title="タイトルを入力" label-text="30文字以内" />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <TextField
              v-model="title"
              rules="required|max:30"
              label="タイトル"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="4" class="pb-0">
            <FormLabel label-title="説明を入力" label-text="300文字以内" />
          </v-col>
          <v-col cols="12" sm="8" class="pb-0">
            <TextArea
              v-model="description"
              rules="required|max:300"
              label="説明"
            />
          </v-col>
        </v-row>
        <v-row justify="center">
          <v-col cols="12" sm="4">
            <v-btn
              v-if="!loadShow"
              block
              rounded
              color="primary"
              class="white--text font-weight-bold d-block mx-auto"
              :disabled="invalid"
              @click="sendTopic"
            >
              トピックを投稿する
            </v-btn>
            <Loading v-show="loadShow" />
          </v-col>
        </v-row>
      </v-form>
    </validation-observer>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import PageHeader from '~/components/layout/PageHeader.vue'
import FormLabel from '~/components/layout/FormLabel.vue'
import TextField from '~/components/input/TextField.vue'
import TextArea from '~/components/input/TextArea.vue'
import Loading from '~/components/layout/Loading.vue'

export default {
  components: {
    PageHeader,
    FormLabel,
    TextField,
    TextArea,
    Loading
  },
  middleware: 'unAuthenticated',
  data() {
    return {
      title: '',
      description: '',
      loadShow: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser'
    })
  },
  methods: {
    ...mapActions({
      showMessage: 'flashMessage/showMessage'
    }),
    async sendTopic() {
      this.loadShow = true
      await this.$axios
        .post('api/v1/topics', {
          title: this.title,
          description: this.description,
          user_id: this.currentUser.id,
          uid: localStorage.getItem('uid')
        })
        .then((response) => {
          this.loadShow = false
          // this.$router.push(`/topic/${response.data.id}`)
          this.$router.push({ path: '/topic/list', query: { page: 1 } })
          this.showMessage({
            text: 'トピックの投稿に成功しました',
            status: true
          })
        })
        .catch((error) => {
          this.loadShow = false
          this.showMessage({
            text: 'トピックの投稿に失敗しました',
            status: true
          })
          return error
        })
    }
  },
  head() {
    return {
      title: 'トピック投稿'
    }
  }
}
</script>
