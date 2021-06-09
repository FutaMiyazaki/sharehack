// 未ログインユーザーはログインページへリダイレクト
export default function({ store, route, redirect }) {
  if (
    !store.getters['authentication/isLoggedIn'] &&
    route.fullPath !== '/' &&
    route.fullPath !== '/users/login' &&
    route.fullPath !== '/users/signup' &&
    route.fullPath !== `/users/${route.params.id}` &&
    route.fullPath !== `/mylike/${route.params.id}` &&
    route.fullPath !== `/item/${route.params.id}`
  ) {
    return redirect('/users/login')
  }
}
