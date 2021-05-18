import Vue from 'vue'
import {
  ValidationProvider,
  ValidationObserver,
  extend,
  localize
} from 'vee-validate'
import ja from 'vee-validate/dist/locale/ja.json'
import { required, max, email } from 'vee-validate/dist/rules'

extend('required', {
  ...required,
  message: 'この項目は必須入力です'
})

extend('max', {
  ...max,
  message: '{length}文字以下で入力してください'
})

extend('email', {
  ...email,
  message: 'メールアドレスの形式に誤りがあります'
})

localize('ja', ja)

Vue.component('ValidationProvider', ValidationProvider)
Vue.component('ValidationObserver', ValidationObserver)
