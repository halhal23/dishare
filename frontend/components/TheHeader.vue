<template>
  <header>
    <ul>
      <li>
        <nuxt-link to="/">ホーム</nuxt-link>
      </li>
      <li>
        <nuxt-link to="/">このサイトについて</nuxt-link>
      </li>
      <li>
        <img src="images/text-logo.png" height="70px" width="210px">
      </li>
      <li>
        <nuxt-link to="/login" v-if="!$auth.$state.loggedIn">ログイン</nuxt-link>
        <a href="#" @click="logout" v-else>ログアウト</a>
      </li>
      <li>
        <nuxt-link to="/">新規登録</nuxt-link>
      </li>
    </ul>
  </header>
</template>

<script>
export default {
  methods: {
    async logout(){
      console.log(this.$store)
      await this.$auth.logout({
          email: 'halhal@gmail.com'
      }).then( res => {
        console.log('ログアウト成功')
        console.log(res)
        return res
      }).catch( err => {
        console.log('ログアウト失敗')
        console.log(err)
        return err
      })
    }
  }
}
</script>

<style scoped>
header {
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 2;
  background: rgba(255,255,255,0.5)
}

ul {
  display: flex;
  justify-content: space-around;
}

li {
  text-decoration: none;
  list-style: none;
}

a {
  line-height: 70px;
  text-decoration: none;
  color: black;
}
</style>